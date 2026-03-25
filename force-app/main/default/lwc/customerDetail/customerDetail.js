import { LightningElement, api, track, wire } from "lwc";
import { CurrentPageReference } from "lightning/navigation";
import { refreshApex } from "@salesforce/apex";
import { ShowToastEvent } from "lightning/platformShowToastEvent";
import FORM_FACTOR from "@salesforce/client/formFactor";
import getCustomerDetail from "@salesforce/apex/CustomerDetailCtrl.getCustomerDetail";
import createNote from "@salesforce/apex/CustomerDetailCtrl.createNote";

// 日付フォーマット（YYYY/MM/DD）
function formatDate(dateStr) {
  if (!dateStr) return "—";
  const d = new Date(dateStr);
  if (isNaN(d)) return dateStr;
  const y = d.getFullYear();
  const m = String(d.getMonth() + 1).padStart(2, "0");
  const day = String(d.getDate()).padStart(2, "0");
  return `${y}/${m}/${day}`;
}

// 日時フォーマット（YYYY/MM/DD HH:mm）
function formatDatetime(dtStr) {
  if (!dtStr) return "—";
  const d = new Date(dtStr);
  if (isNaN(d)) return dtStr;
  const y = d.getFullYear();
  const mo = String(d.getMonth() + 1).padStart(2, "0");
  const day = String(d.getDate()).padStart(2, "0");
  const h = String(d.getHours()).padStart(2, "0");
  const mi = String(d.getMinutes()).padStart(2, "0");
  return `${y}/${mo}/${day} ${h}:${mi}`;
}

// 数値フォーマット（3桁カンマ）
function formatNum(val) {
  if (val === null || val === undefined) return "—";
  return Number(val).toLocaleString("ja-JP");
}

// 残日数に応じたCSSクラス
function zanCssClass(days) {
  if (days === null || days === undefined) return "info-value";
  if (days < 0) return "info-value val--danger";
  if (days < 30) return "info-value val--warning";
  if (days < 90) return "info-value val--caution";
  return "info-value val--ok";
}

// タイヤ溝に応じたCSSクラス
function tireCssClass(mm) {
  if (mm === null || mm === undefined) return "tire-cell tire-cell--none";
  if (mm < 1.6) return "tire-cell tire-cell--danger";
  if (mm < 3.0) return "tire-cell tire-cell--warning";
  return "tire-cell tire-cell--ok";
}

// HTMLタグ除去（ContentNote本文用）
function stripHtml(html) {
  if (!html) return "";
  return html.replace(/<[^>]*>/g, "").trim();
}

export default class CustomerDetail extends LightningElement {
  _contactId = null;
  @track detail = null;
  @track isLoading = false;
  @track errorMessage = "";

  // メモ追加モーダル用
  @track showNewNoteModal = false;
  @track newNoteTitle = "";
  @track newNoteBody = "";
  @track isSaving = false;

  // モバイル判定
  get containerClass() {
    return FORM_FACTOR === "Small" ? "mobile" : "";
  }

  // 外部（モーダル）からも設定可能
  @api
  get contactId() {
    return this._contactId;
  }
  set contactId(value) {
    if (value && value !== this._contactId) {
      this._contactId = value;
      this.loadData();
    }
  }

  // URLパラメータから取得（スタンドアロンページ用）
  @wire(CurrentPageReference)
  pageRef(ref) {
    if (!ref) return;
    const cid = ref?.state?.c__contactId || ref?.attributes?.recordId;
    if (cid && cid !== this._contactId) {
      this._contactId = cid;
      this.loadData();
    }
  }

  async loadData() {
    if (!this._contactId) return;
    this.isLoading = true;
    this.errorMessage = "";
    try {
      const raw = await getCustomerDetail({ contactId: this.contactId });
      this.detail = this.transform(raw);
    } catch (e) {
      console.error("CustomerDetail Error:", JSON.stringify(e));
      let msg = "データの取得に失敗しました";
      if (e?.body?.message) {
        msg = e.body.message;
      } else if (e?.message) {
        msg = e.message;
      }
      this.errorMessage = msg;
    } finally {
      this.isLoading = false;
    }
  }

  // ── データ変換 ──────────────────────────────────────────────
  transform(raw) {
    // Contact — Apexの返却オブジェクトはfrozenなのでコピーする
    const contact = {
      ...raw.contact,
      formattedBirthdate: formatDate(raw.contact.birthdate)
    };

    // 保険 Map（sharyoId -> HokenWrapper）
    const hokenBySharyoId = {};
    const unlinked = [];
    for (const h of raw.hokenList || []) {
      const hCopy = {
        ...h,
        formattedShikibi: formatDate(h.shikibi),
        formattedMankibi: formatDate(h.mankibi)
      };
      if (hCopy.sharyoId) {
        hokenBySharyoId[hCopy.sharyoId] = hCopy;
      } else {
        unlinked.push(hCopy);
      }
    }

    // JAF
    const jafList = (raw.jafList || []).map((j) => ({
      ...j,
      formattedMankibi: formatDate(j.mankibi),
      formattedMousikomDate: formatDate(j.mousikomDate)
    }));

    // ContentNote
    const contentNotes = (raw.contentNotes || []).map((n) => ({
      ...n,
      bodyPreview: stripHtml(n.body),
      formattedLastModified: formatDatetime(n.lastModifiedDate)
    }));

    // 車両
    const vehicleList = (raw.sharyoList || []).map((v) => {
      const linkedHoken = hokenBySharyoId[v.id] || null;
      return {
        ...v,
        // 基本
        formattedShodoToroku: formatDate(v.shodoTorokuNengappi),
        // 査定
        formattedSaisinSateiBi: formatDate(v.saisinSateiBi),
        formattedSaisinSateiKingaku: formatNum(v.saisinSateiKingaku),
        // 車検・点検
        formattedShakenManryobi: formatDate(v.shakenManryobi),
        formattedTenkenYoteibi: formatDate(v.tenkenYoteibi),
        shakenCssClass: zanCssClass(
          v.shakenManryobi
            ? Math.floor((new Date(v.shakenManryobi) - new Date()) / 86400000)
            : null
        ),
        tenkenZanCssClass: zanCssClass(v.tenkenZanNissu),
        // 割賦
        formattedKappuGankin: formatNum(v.kappuGankin),
        formattedHeigetsu: formatNum(v.heigetsuShiharai),
        formattedKappuKansaiYoteibi: formatDate(v.kappuKansaiYoteibi),
        kappuManryoCssClass: zanCssClass(v.kappuManryo),
        // タイヤ（冬）
        formattedFuyuNyuryoku: formatDate(v.fuyuTireNyuryokubi),
        fuyuZenMigiClass: tireCssClass(v.fuyuZenMigi),
        fuyuKoMigiClass: tireCssClass(v.fuyuKoMigi),
        fuyuZenHidariClass: tireCssClass(v.fuyuZenHidari),
        fuyuKoHidariClass: tireCssClass(v.fuyuKoHidari),
        // タイヤ（夏）
        formattedNatsuNyuryoku: formatDate(v.natsuTireNyuryokubi),
        natsuZenMigiClass: tireCssClass(v.natsuZenMigi),
        natsuKoMigiClass: tireCssClass(v.natsuKoMigi),
        natsuZenHidariClass: tireCssClass(v.natsuZenHidari),
        natsuKoHidariClass: tireCssClass(v.natsuKoHidari),
        // TC
        formattedTcHokenMankibi: formatDate(v.tcHokenMankibi),
        formattedTcKeiyakubi: formatDate(v.tcKeiyakubi),
        formattedTcKeiyakuMankibi: formatDate(v.tcKeiyakuMankibi),
        // 保険
        linkedHoken,
        hasLinkedHoken: !!linkedHoken,
        // タブラベル（データ欠損時に 🔴 表示）
        sateiTabLabel: v.saisinSateiBi ? "査定" : "🔴 査定",
        hokenTabLabel: linkedHoken ? "保険" : "🔴 保険"
      };
    });

    return {
      contact,
      vehicleList,
      jafList,
      contentNotes,
      unlinkedHokenList: unlinked,
      daigaeScore: raw.daigaeScore,
      daigaeRank: raw.daigaeRank,
      daigaeShodanMemoDate: raw.daigaeShodanMemoDate
    };
  }

  // ── Getters ─────────────────────────────────────────────────
  get hasData() {
    return !!this.detail;
  }
  get hasError() {
    return !!this.errorMessage;
  }
  get vehicleList() {
    return this.detail?.vehicleList || [];
  }
  get vehicleCount() {
    return this.vehicleList.length;
  }
  get hasVehicles() {
    return this.vehicleCount > 0;
  }
  get hasJaf() {
    return (this.detail?.jafList || []).length > 0;
  }
  get hasUnlinkedHoken() {
    return (this.detail?.unlinkedHokenList || []).length > 0;
  }
  get unlinkedHokenList() {
    return this.detail?.unlinkedHokenList || [];
  }
  get formattedBirthdate() {
    return this.detail?.contact?.formattedBirthdate || "—";
  }
  get phoneLink() {
    return "tel:" + (this.detail?.contact?.phone || "");
  }
  get mobilePhoneLink() {
    return "tel:" + (this.detail?.contact?.mobilePhone || "");
  }
  get emailLink() {
    return "mailto:" + (this.detail?.contact?.email || "");
  }

  get codeLabel() {
    return "#" + (this.detail?.contact?.okyakusamacode || "");
  }

  get daigaeRankStars() {
    const rank = this.detail?.daigaeRank || 0;
    if (rank === 0) return null;
    return "★".repeat(rank) + "☆".repeat(5 - rank);
  }

  get hasDaigaeRank() {
    return (this.detail?.daigaeRank || 0) > 0;
  }

  get daigaeMemoDateLabel() {
    const d = this.detail?.daigaeShodanMemoDate;
    if (!d) return null;
    return "商談メモ " + formatDate(d);
  }

  get hasDaigaeMemoDate() {
    return !!this.detail?.daigaeShodanMemoDate;
  }

  // 保険(未紐づき)またはJAFがあるか
  get hasUnlinkedHokenOrJaf() {
    return this.hasUnlinkedHoken || this.hasJaf;
  }

  // ContentNote getters
  get contentNoteList() {
    return this.detail?.contentNotes || [];
  }
  get hasContentNotes() {
    return this.contentNoteList.length > 0;
  }
  get isNewNoteValid() {
    return this.newNoteTitle && this.newNoteTitle.trim().length > 0;
  }


  // ── メモ追加ハンドラ ────────────────────────────────────────
  handleOpenNewNote() {
    this.newNoteTitle = "";
    this.newNoteBody = "";
    this.showNewNoteModal = true;
  }

  handleCloseNewNote() {
    this.showNewNoteModal = false;
  }

  handleNoteTitleChange(event) {
    this.newNoteTitle = event.target.value;
  }

  handleNoteBodyChange(event) {
    this.newNoteBody = event.target.value;
  }

  async handleSaveNote() {
    if (!this.isNewNoteValid) return;
    this.isSaving = true;
    try {
      await createNote({
        contactId: this.contactId,
        title: this.newNoteTitle.trim(),
        body: this.newNoteBody.trim()
      });
      this.showNewNoteModal = false;
      // データを再取得
      await this.loadData();
      this.dispatchEvent(
        new ShowToastEvent({
          title: "成功",
          message: "メモを保存しました",
          variant: "success"
        })
      );
    } catch (e) {
      console.error("CreateNote Error:", JSON.stringify(e));
      let msg = "メモの保存に失敗しました";
      if (e?.body?.message) {
        msg = e.body.message;
      }
      this.dispatchEvent(
        new ShowToastEvent({
          title: "エラー",
          message: msg,
          variant: "error"
        })
      );
    } finally {
      this.isSaving = false;
    }
  }
}