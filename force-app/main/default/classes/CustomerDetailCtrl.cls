public with sharing class CustomerDetailCtrl {
  // ─── Wrapper: レスポンス全体 ───────────────────────────────
  public class CustomerDetailWrapper {
    @AuraEnabled
    public ContactWrapper contact { get; set; }
    @AuraEnabled
    public List<SharyoWrapper> sharyoList { get; set; }
    @AuraEnabled
    public List<HokenWrapper> hokenList { get; set; }
    @AuraEnabled
    public List<JAFWrapper> jafList { get; set; }
    @AuraEnabled
    public List<ContentNoteWrapper> contentNotes { get; set; }
    @AuraEnabled
    public List<CallTaskWrapper> callTaskList { get; set; }
    @AuraEnabled
    public List<AuWrapper> auList { get; set; }
    @AuraEnabled
    public Decimal daigaeScore { get; set; }
    @AuraEnabled
    public Integer daigaeRank { get; set; }
    @AuraEnabled
    public Date daigaeShodanMemoDate { get; set; }
  }

  // ─── ContentNote ──────────────────────────────────────────
  public class ContentNoteWrapper {
    @AuraEnabled
    public String id { get; set; }
    @AuraEnabled
    public String title { get; set; }
    @AuraEnabled
    public String body { get; set; }
    @AuraEnabled
    public Datetime lastModifiedDate { get; set; }
    @AuraEnabled
    public String lastModifiedByName { get; set; }
  }

  // ─── CallTask ────────────────────────────────────────────
  public class CallTaskWrapper {
    @AuraEnabled
    public String id { get; set; }
    @AuraEnabled
    public String subject { get; set; }
    @AuraEnabled
    public String description { get; set; }
    @AuraEnabled
    public Datetime createdDate { get; set; }
    @AuraEnabled
    public String createdByName { get; set; }
  }

  // ─── au携帯契約 ────────────────────────────────────────
  public class AuWrapper {
    @AuraEnabled
    public String id { get; set; }
    @AuraEnabled
    public String auTel { get; set; }
    @AuraEnabled
    public String kishuMeisho { get; set; }
    @AuraEnabled
    public String kishu { get; set; }
    @AuraEnabled
    public String ryokinPlan { get; set; }
    @AuraEnabled
    public String keiyakuShubetsu { get; set; }
    @AuraEnabled
    public Date keitaiKonyubi { get; set; }
    @AuraEnabled
    public Decimal tanmatsuRiyou { get; set; }
    @AuraEnabled
    public Decimal keitaiKappuShiharaiGaku { get; set; }
    @AuraEnabled
    public Decimal keitaiKappuShiharaiKaisuu { get; set; }
    @AuraEnabled
    public String keitaiKappuShuryoYotei { get; set; }
    @AuraEnabled
    public Decimal keitaiZansaiKingaku { get; set; }
    @AuraEnabled
    public String keiyakushaMei { get; set; }
    @AuraEnabled
    public String keiyakuKoshinbiFrom { get; set; }
    @AuraEnabled
    public String keiyakuKoshinbiTo { get; set; }
    @AuraEnabled
    public String ugpFrom { get; set; }
    @AuraEnabled
    public String ugpTo { get; set; }
    @AuraEnabled
    public String ugpMeisho { get; set; }
    @AuraEnabled
    public String membersTorokubiText { get; set; }
  }

  // ─── Contact ─────────────────────────────────────────────
  public class ContactWrapper {
    @AuraEnabled
    public String id { get; set; }
    @AuraEnabled
    public String name { get; set; }
    @AuraEnabled
    public String okyakusamacode { get; set; }
    @AuraEnabled
    public String okyakusamaKana { get; set; }
    @AuraEnabled
    public String okyakusamaSobetsu { get; set; }
    @AuraEnabled
    public String seibetsu { get; set; }
    @AuraEnabled
    public Decimal nenrei { get; set; }
    @AuraEnabled
    public Date birthdate { get; set; }
    @AuraEnabled
    public String mailingAddress { get; set; }
    @AuraEnabled
    public String otherAddress { get; set; }
    @AuraEnabled
    public String phone { get; set; }
    @AuraEnabled
    public String email { get; set; }
    @AuraEnabled
    public String mobilePhone { get; set; }
    @AuraEnabled
    public String tsaGroup { get; set; }
    @AuraEnabled
    public Decimal botoruZanryo { get; set; }
    @AuraEnabled
    public Decimal cardPoint { get; set; }
    @AuraEnabled
    public String shutantosha { get; set; }
  }

  // ─── 車両 ─────────────────────────────────────────────────
  public class SharyoWrapper {
    @AuraEnabled
    public String id { get; set; }
    // 基本
    @AuraEnabled
    public String name { get; set; }
    @AuraEnabled
    public String carName { get; set; }
    @AuraEnabled
    public String maker { get; set; }
    @AuraEnabled
    public String katashiki { get; set; }
    @AuraEnabled
    public String shinchuKubun { get; set; }
    @AuraEnabled
    public String keiKubun { get; set; }
    @AuraEnabled
    public Decimal sokoKyori { get; set; }
    @AuraEnabled
    public Decimal keikanensu { get; set; }
    @AuraEnabled
    public String sharyoSobetsu { get; set; }
    @AuraEnabled
    public Boolean ssFlg { get; set; }
    @AuraEnabled
    public Date shodoTorokuNengappi { get; set; }
    @AuraEnabled
    public Date uCarTorokubi { get; set; }
    // 査定
    @AuraEnabled
    public Date saisinSateiBi { get; set; }
    @AuraEnabled
    public Decimal saisinSateiKyori { get; set; }
    @AuraEnabled
    public Decimal saisinSateiKingaku { get; set; }
    // 車検・点検
    @AuraEnabled
    public Date shakenManryobi { get; set; }
    @AuraEnabled
    public String tenkenShubetsu { get; set; }
    @AuraEnabled
    public String tenkenYutiStatus { get; set; }
    @AuraEnabled
    public Date tenkenYoteibi { get; set; }
    @AuraEnabled
    public Decimal tenkenZanNissu { get; set; }
    // 割賦
    @AuraEnabled
    public Decimal kappuGankin { get; set; }
    @AuraEnabled
    public Decimal kappuKaisu { get; set; }
    @AuraEnabled
    public Date kappuKansaiYoteibi { get; set; }
    @AuraEnabled
    public String kappuKansaiKubun { get; set; }
    @AuraEnabled
    public Date kappuKansaibi { get; set; }
    @AuraEnabled
    public Decimal heigetsuShiharai { get; set; }
    @AuraEnabled
    public Decimal kappuManryo { get; set; }
    @AuraEnabled
    public String mpMeisho { get; set; }
    // タイヤ（冬）
    @AuraEnabled
    public Date fuyuTireNyuryokubi { get; set; }
    @AuraEnabled
    public Decimal fuyuZenMigi { get; set; }
    @AuraEnabled
    public Decimal fuyuKoMigi { get; set; }
    @AuraEnabled
    public Decimal fuyuZenHidari { get; set; }
    @AuraEnabled
    public Decimal fuyuKoHidari { get; set; }
    // タイヤ（夏）
    @AuraEnabled
    public Date natsuTireNyuryokubi { get; set; }
    @AuraEnabled
    public Decimal natsuZenMigi { get; set; }
    @AuraEnabled
    public Decimal natsuKoMigi { get; set; }
    @AuraEnabled
    public Decimal natsuZenHidari { get; set; }
    @AuraEnabled
    public Decimal natsuKoHidari { get; set; }
    // TC（テレマティクス）
    @AuraEnabled
    public String tcHokenKanyuUmu { get; set; }
    @AuraEnabled
    public String tcHokenShohinmei { get; set; }
    @AuraEnabled
    public Date tcHokenMankibi { get; set; }
    @AuraEnabled
    public String tcKeiyakuService { get; set; }
    @AuraEnabled
    public Date tcKeiyakubi { get; set; }
    @AuraEnabled
    public Date tcKeiyakuMankibi { get; set; }
    @AuraEnabled
    public String tcRyokinPlan { get; set; }
    @AuraEnabled
    public String tcTsushinKiki { get; set; }
  }

  // ─── 保険 ─────────────────────────────────────────────────
  public class HokenWrapper {
    @AuraEnabled
    public String id { get; set; }
    @AuraEnabled
    public String name { get; set; }
    @AuraEnabled
    public String kaishaMei { get; set; }
    @AuraEnabled
    public String keiyakuKubun { get; set; }
    @AuraEnabled
    public Date shikibi { get; set; }
    @AuraEnabled
    public Date mankibi { get; set; }
    @AuraEnabled
    public String tokyu { get; set; }
    @AuraEnabled
    public String shokenBango { get; set; }
    @AuraEnabled
    public String sharyoId { get; set; }
  }

  // ─── JAF ──────────────────────────────────────────────────
  public class JAFWrapper {
    @AuraEnabled
    public String id { get; set; }
    @AuraEnabled
    public String kaiinNumber { get; set; }
    @AuraEnabled
    public String nameKanji { get; set; }
    @AuraEnabled
    public String kaiinShubetu { get; set; }
    @AuraEnabled
    public String nyukaiKeizoku { get; set; }
    @AuraEnabled
    public Decimal year { get; set; }
    @AuraEnabled
    public Date mankibi { get; set; }
    @AuraEnabled
    public String nyukinKubun { get; set; }
    @AuraEnabled
    public String mousikomNaiyo { get; set; }
    @AuraEnabled
    public Date mousikomDate { get; set; }
    @AuraEnabled
    public String mousikomShubetu { get; set; }
  }

  // ─── メイン取得メソッド ────────────────────────────────────
  @AuraEnabled(cacheable=true)
  public static CustomerDetailWrapper getCustomerDetail(String contactId) {
    CustomerDetailWrapper result = new CustomerDetailWrapper();

    // Contact
    Contact con = [
      SELECT
        Id,
        Name,
        Okyakusamacode__c,
        OkyakusamaKana__c,
        OkyakusamaSobetsu__c,
        Seibetsu__c,
        Nenrei__c,
        Birthdate,
        MailingStreet,
        MailingCity,
        MailingState,
        MailingPostalCode,
        OtherStreet,
        OtherCity,
        OtherState,
        OtherPostalCode,
        Phone,
        Email,
        MobilePhone,
        TSAGroup__c,
        BotoruGoukeiZanryo__c,
        SaisinCardPoint__c,
        Shutantosha__c
      FROM Contact
      WHERE Id = :contactId
      LIMIT 1
    ];

    ContactWrapper cw = new ContactWrapper();
    cw.id = con.Id;
    cw.name = con.Name;
    cw.okyakusamacode = con.Okyakusamacode__c;
    cw.okyakusamaKana = con.OkyakusamaKana__c;
    cw.okyakusamaSobetsu = con.OkyakusamaSobetsu__c;
    cw.seibetsu = con.Seibetsu__c;
    cw.nenrei = con.Nenrei__c;
    cw.birthdate = con.Birthdate;
    cw.mailingAddress = buildAddress(
      con.MailingPostalCode,
      con.MailingState,
      con.MailingCity,
      con.MailingStreet
    );
    cw.otherAddress = buildAddress(
      con.OtherPostalCode,
      con.OtherState,
      con.OtherCity,
      con.OtherStreet
    );
    cw.phone = con.Phone;
    cw.email = con.Email;
    cw.mobilePhone = con.MobilePhone;
    cw.tsaGroup = con.TSAGroup__c;
    cw.botoruZanryo = con.BotoruGoukeiZanryo__c;
    cw.cardPoint = con.SaisinCardPoint__c;
    cw.shutantosha = con.Shutantosha__c;
    result.contact = cw;

    // 車両（複数）
    List<Sharyo__c> sharyoList = [
      SELECT
        Id,
        Name,
        carName__c,
        Maker__c,
        Katashiki__c,
        ShinchuKubunCode__c,
        KeiKubunCode__c,
        SokoKyori__c,
        SharyokonyukaranoKeikanensu__c,
        SharyoSobetsu__c,
        SSFlg__c,
        ShodoTorokuNengappi__c,
        UCarTorokubi__c,
        SaisinSateiBi__c,
        SaisinSateikyori__c,
        SaisinSateikinngaku__c,
        ShakenManryobi__c,
        TeikiTenkenShubetsu__c,
        TenkenYutiStatus__c,
        TenkenYoteibi__c,
        TenkensuisyoBiZan__c,
        KappuGankinEn__c,
        KappuKaisu__c,
        KappuKansaiYoteibi__c,
        KappuKansaiKubun__c,
        KappuKansaibi__c,
        HeigetsuShiharaigakuEn__c,
        KappuManryo__c,
        MaintenancePackShohinMeisho2__c,
        FuyuTireNokoriMizoNyuryokubi__c,
        FuyuTireNokoriMizoZenrinMigi__c,
        FuyuTireNokoriMizoKorinMigi__c,
        FuyuTireNokoriMizoZenrinHidari__c,
        FuyuTireNokoriMizoKorinHidari__c,
        NatsuTireNokoriMizoNyuryokubi__c,
        NatsuTireNokoriMizoZenrinMigi__c,
        NatsuTireNokoriMizoKorinMigi__c,
        NatsuTireNokoriMizoZenrinHidari__c,
        NatsuTireNokoriMizoKorinHidari__c,
        TelematicsHokenKanyuUmu__c,
        TelematicsHokenSyohinmei__c,
        TelematicsHokenMankibi__c,
        KeiyakuService2__c,
        Keiyakubi__c,
        TelematicsKeiyakuMankibi__c,
        RyokinPlan2__c,
        TsushinKiki2__c
      FROM Sharyo__c
      WHERE Okyakusama__c = :contactId AND MaxshoFlg__c = FALSE
      ORDER BY Name ASC
    ];

    result.sharyoList = new List<SharyoWrapper>();
    for (Sharyo__c s : sharyoList) {
      SharyoWrapper sw = new SharyoWrapper();
      sw.id = s.Id;
      sw.name = s.Name;
      sw.carName = s.carName__c;
      sw.maker = s.Maker__c;
      sw.katashiki = s.Katashiki__c;
      sw.shinchuKubun = convertShinchuKubun(s.ShinchuKubunCode__c);
      sw.keiKubun = s.KeiKubunCode__c;
      sw.sokoKyori = s.SokoKyori__c;
      sw.keikanensu = s.SharyokonyukaranoKeikanensu__c;
      sw.sharyoSobetsu = s.SharyoSobetsu__c;
      sw.ssFlg = s.SSFlg__c;
      sw.shodoTorokuNengappi = s.ShodoTorokuNengappi__c;
      sw.uCarTorokubi = s.UCarTorokubi__c;
      sw.saisinSateiBi = s.SaisinSateiBi__c;
      sw.saisinSateiKyori = s.SaisinSateikyori__c;
      sw.saisinSateiKingaku = s.SaisinSateikinngaku__c;
      sw.shakenManryobi = s.ShakenManryobi__c;
      sw.tenkenShubetsu = s.TeikiTenkenShubetsu__c;
      sw.tenkenYutiStatus = s.TenkenYutiStatus__c;
      sw.tenkenYoteibi = s.TenkenYoteibi__c;
      sw.tenkenZanNissu = s.TenkensuisyoBiZan__c;
      sw.kappuGankin = s.KappuGankinEn__c;
      sw.kappuKaisu = s.KappuKaisu__c;
      sw.kappuKansaiYoteibi = s.KappuKansaiYoteibi__c;
      sw.kappuKansaiKubun = s.KappuKansaiKubun__c;
      sw.kappuKansaibi = s.KappuKansaibi__c;
      sw.heigetsuShiharai = s.HeigetsuShiharaigakuEn__c;
      sw.kappuManryo = s.KappuManryo__c;
      sw.mpMeisho = s.MaintenancePackShohinMeisho2__c;
      sw.fuyuTireNyuryokubi = s.FuyuTireNokoriMizoNyuryokubi__c;
      sw.fuyuZenMigi = s.FuyuTireNokoriMizoZenrinMigi__c;
      sw.fuyuKoMigi = s.FuyuTireNokoriMizoKorinMigi__c;
      sw.fuyuZenHidari = s.FuyuTireNokoriMizoZenrinHidari__c;
      sw.fuyuKoHidari = s.FuyuTireNokoriMizoKorinHidari__c;
      sw.natsuTireNyuryokubi = s.NatsuTireNokoriMizoNyuryokubi__c;
      sw.natsuZenMigi = s.NatsuTireNokoriMizoZenrinMigi__c;
      sw.natsuKoMigi = s.NatsuTireNokoriMizoKorinMigi__c;
      sw.natsuZenHidari = s.NatsuTireNokoriMizoZenrinHidari__c;
      sw.natsuKoHidari = s.NatsuTireNokoriMizoKorinHidari__c;
      sw.tcHokenKanyuUmu = s.TelematicsHokenKanyuUmu__c;
      sw.tcHokenShohinmei = s.TelematicsHokenSyohinmei__c;
      sw.tcHokenMankibi = s.TelematicsHokenMankibi__c;
      sw.tcKeiyakuService = s.KeiyakuService2__c;
      sw.tcKeiyakubi = s.Keiyakubi__c;
      sw.tcKeiyakuMankibi = s.TelematicsKeiyakuMankibi__c;
      sw.tcRyokinPlan = s.RyokinPlan2__c;
      sw.tcTsushinKiki = s.TsushinKiki2__c;
      result.sharyoList.add(sw);
    }

    // 保険
    List<Hoken__c> hokenList = [
      SELECT
        Id,
        Name,
        HokenKaishaMei2__c,
        KeiyakuKubun__c,
        Shikibi__c,
        Mankibi__c,
        TokyuTokyu__c,
        ShokenBango__c,
        SharyoId__c
      FROM Hoken__c
      WHERE ContactId__c = :contactId AND HyojiFlg1__c = TRUE
      ORDER BY Mankibi__c ASC
    ];

    result.hokenList = new List<HokenWrapper>();
    for (Hoken__c h : hokenList) {
      HokenWrapper hw = new HokenWrapper();
      hw.id = h.Id;
      hw.name = h.Name;
      hw.kaishaMei = h.HokenKaishaMei2__c;
      hw.keiyakuKubun = h.KeiyakuKubun__c;
      hw.shikibi = h.Shikibi__c;
      hw.mankibi = h.Mankibi__c;
      hw.tokyu = h.TokyuTokyu__c;
      hw.shokenBango = h.ShokenBango__c;
      hw.sharyoId = h.SharyoId__c;
      result.hokenList.add(hw);
    }

    // JAF
    List<JAF__c> jafList = [
      SELECT
        Id,
        KaiinNumber__c,
        NameKanji__c,
        KaiinShubetu__c,
        NyukaiKeizoku__c,
        Year__c,
        Mankibi__c,
        NyukinKubun__c,
        Mousiokominaiyo__c,
        MousiokiDate__c,
        MousikomiShubetu__c
      FROM JAF__c
      WHERE Contact__c = :contactId
      ORDER BY MousiokiDate__c DESC
    ];

    result.jafList = new List<JAFWrapper>();
    Set<String> seenJafKaiin = new Set<String>();
    for (JAF__c j : jafList) {
      // 会員番号で重複除外（ORDER BYにより最新が先頭）
      String kaiinKey = j.KaiinNumber__c != null ? j.KaiinNumber__c : '';
      if (seenJafKaiin.contains(kaiinKey)) {
        continue;
      }
      seenJafKaiin.add(kaiinKey);

      JAFWrapper jw = new JAFWrapper();
      jw.id = j.Id;
      jw.kaiinNumber = j.KaiinNumber__c;
      jw.nameKanji = j.NameKanji__c;
      jw.kaiinShubetu = j.KaiinShubetu__c;
      jw.nyukaiKeizoku = j.NyukaiKeizoku__c;
      jw.year = j.Year__c;
      jw.mankibi = j.Mankibi__c;
      jw.nyukinKubun = j.NyukinKubun__c;
      jw.mousikomNaiyo = j.Mousiokominaiyo__c;
      jw.mousikomDate = j.MousiokiDate__c;
      jw.mousikomShubetu = j.MousikomiShubetu__c;
      result.jafList.add(jw);
    }

    // 代替促進候補（JyuchuStatusがブランクまたは商談メモのレコード）
    List<DaigaeSokusinKouho__c> daigaeList = [
      SELECT Id, SCORE1__c, ShodanMemoSakuseiBi__c
      FROM DaigaeSokusinKouho__c
      WHERE
        contactId__c = :contactId
        AND (JyuchuStatus__c = NULL
        OR JyuchuStatus__c = ''
        OR JyuchuStatus__c = 'A')
      ORDER BY SCORE1__c DESC NULLS LAST
      LIMIT 1
    ];
    if (!daigaeList.isEmpty()) {
      DaigaeSokusinKouho__c d = daigaeList[0];
      result.daigaeScore = d.SCORE1__c;
      result.daigaeRank = convertScoreToRank(d.SCORE1__c);
      result.daigaeShodanMemoDate = d.ShodanMemoSakuseiBi__c;
    }

    // ContentNote（メモ）最新3件
    List<ContentDocumentLink> cdlList = [
      SELECT
        ContentDocumentId,
        ContentDocument.Title,
        ContentDocument.LastModifiedDate,
        ContentDocument.LastModifiedBy.Name
      FROM ContentDocumentLink
      WHERE
        LinkedEntityId = :contactId
        AND ContentDocument.FileType = 'SNOTE'
      ORDER BY ContentDocument.LastModifiedDate DESC
      LIMIT 3
    ];

    result.contentNotes = new List<ContentNoteWrapper>();
    if (!cdlList.isEmpty()) {
      Set<Id> noteIds = new Set<Id>();
      for (ContentDocumentLink cdl : cdlList) {
        noteIds.add(cdl.ContentDocumentId);
      }
      Map<Id, ContentNote> noteMap = new Map<Id, ContentNote>([
        SELECT Id, Title, Content
        FROM ContentNote
        WHERE Id IN :noteIds
      ]);
      for (ContentDocumentLink cdl : cdlList) {
        ContentNoteWrapper nw = new ContentNoteWrapper();
        nw.id = cdl.ContentDocumentId;
        nw.title = cdl.ContentDocument.Title;
        nw.lastModifiedDate = cdl.ContentDocument.LastModifiedDate;
        nw.lastModifiedByName = cdl.ContentDocument.LastModifiedBy.Name;
        ContentNote cn = noteMap.get(cdl.ContentDocumentId);
        if (cn != null && cn.Content != null) {
          nw.body = cn.Content.toString();
        }
        result.contentNotes.add(nw);
      }
    }

    // ─── 電話発信履歴（最新10件）───────────────────────────
    result.callTaskList = new List<CallTaskWrapper>();
    for (Task ct : [
      SELECT Id, Subject, Description, CreatedDate, CreatedBy.Name
      FROM Task
      WHERE WhoId = :contactId
        AND TaskSubtype = 'Call'
        AND CallType = 'Outbound'
      ORDER BY CreatedDate DESC
      LIMIT 3
    ]) {
      CallTaskWrapper ctw = new CallTaskWrapper();
      ctw.id = ct.Id;
      ctw.subject = ct.Subject;
      ctw.description = ct.Description;
      ctw.createdDate = ct.CreatedDate;
      ctw.createdByName = ct.CreatedBy.Name;
      result.callTaskList.add(ctw);
    }

    // ─── au携帯契約（重複除外・本人優先）──────────────────────
    Map<String, AuWrapper> honninAuMap = new Map<String, AuWrapper>();
    Map<String, AuWrapper> kazokuAuMap = new Map<String, AuWrapper>();
    List<String> honninKeyOrder = new List<String>();
    List<String> kazokuKeyOrder = new List<String>();
    Set<String> seenPhones = new Set<String>(); // 全カテゴリ共通の重複チェック
    String contactName = con.Name;
    for (au__c a : [
      SELECT Id, AuTel__c, KishuMeisho__c, Kishu__c,
             RyokinPlanMeisho__c, KeiyakuNoShubetsu__c,
             KeitaiKonyubi__c, TanmatuRiyou__c,
             KeitaiKappuShiharaiGaku__c, KeitaiKappuShiharaiKaisuu__c,
             KeitaiKappuShuryoYoteizuki_Text__c, KeitaiZansaiKingaku__c,
             KeiyakushameiKanji__c,
             KeiyakuKoshinbiFrom__c, KeiyakuKoshinbiTo__c,
             UGPKenriKoshiKanoNengetsuFrom__c, UGPKenriKoshiKanoNengetsuTo__c,
             UpGradeProgramMeisho__c,
             ToyotaAuMembersTorokubi_Text__c
      FROM au__c
      WHERE ContactName__c = :contactId
      ORDER BY KeiyakuNoShubetsu__c ASC, KeitaiKonyubi__c DESC NULLS LAST
    ]) {
      // 重複判定：電話番号（本人→利用者→家族の順で処理、最初の出現を保持）
      String dedupeKey = a.AuTel__c != null ? a.AuTel__c : '';
      if (seenPhones.contains(dedupeKey)) {
        continue; // 同一番号は本人優先で1件のみ
      }
      seenPhones.add(dedupeKey);

      // KeiyakuNoShubetsu__c でタブ振り分け
      String shubetsu = a.KeiyakuNoShubetsu__c != null ? a.KeiyakuNoShubetsu__c : '';
      Boolean isHonnin = shubetsu.contains('本人');
      Map<String, AuWrapper> targetMap = isHonnin ? honninAuMap : kazokuAuMap;
      List<String> targetOrder = isHonnin ? honninKeyOrder : kazokuKeyOrder;

      targetMap.put(dedupeKey, buildAuWrapper(a));
      targetOrder.add(dedupeKey);
    }
    // 本人を先頭に結合（挿入順を維持）
    result.auList = new List<AuWrapper>();
    for (String k : honninKeyOrder) {
      result.auList.add(honninAuMap.get(k));
    }
    for (String k : kazokuKeyOrder) {
      result.auList.add(kazokuAuMap.get(k));
    }

    return result;
  }
  // ─── au__c → AuWrapper 変換ヘルパー ─────────────────────────
  private static AuWrapper buildAuWrapper(au__c a) {
    AuWrapper aw = new AuWrapper();
    aw.id = a.Id;
    aw.auTel = a.AuTel__c;
    aw.kishuMeisho = a.KishuMeisho__c;
    aw.kishu = a.Kishu__c;
    aw.ryokinPlan = a.RyokinPlanMeisho__c;
    aw.keiyakuShubetsu = a.KeiyakuNoShubetsu__c;
    aw.keitaiKonyubi = a.KeitaiKonyubi__c;
    aw.tanmatsuRiyou = a.TanmatuRiyou__c;
    aw.keitaiKappuShiharaiGaku = a.KeitaiKappuShiharaiGaku__c;
    aw.keitaiKappuShiharaiKaisuu = a.KeitaiKappuShiharaiKaisuu__c;
    aw.keitaiKappuShuryoYotei = a.KeitaiKappuShuryoYoteizuki_Text__c;
    aw.keitaiZansaiKingaku = a.KeitaiZansaiKingaku__c;
    aw.keiyakushaMei = a.KeiyakushameiKanji__c;
    aw.keiyakuKoshinbiFrom = a.KeiyakuKoshinbiFrom__c;
    aw.keiyakuKoshinbiTo = a.KeiyakuKoshinbiTo__c;
    aw.ugpFrom = a.UGPKenriKoshiKanoNengetsuFrom__c;
    aw.ugpTo = a.UGPKenriKoshiKanoNengetsuTo__c;
    aw.ugpMeisho = a.UpGradeProgramMeisho__c;
    aw.membersTorokubiText = a.ToyotaAuMembersTorokubi_Text__c;
    return aw;
  }

  // ─── ユーティリティ ───────────────────────────────────────
  // スコアを★ランク(1-5)に変換 (30未満=0, 30-39=1, 40-49=2, 50-59=3, 60-69=4, 80+=5)
  private static Integer convertScoreToRank(Decimal score) {
    if (score == null || score < 30)
      return 0;
    if (score < 40)
      return 1;
    if (score < 50)
      return 2;
    if (score < 60)
      return 3;
    if (score < 70)
      return 4;
    if (score >= 80)
      return 5;
    return 0;
  }

  private static String convertShinchuKubun(String code) {
    if (code == '1')
      return '新車';
    if (code == '2')
      return 'U-Car';
    return code;
  }

  private static String buildAddress(
    String postal,
    String state,
    String city,
    String street
  ) {
    List<String> parts = new List<String>();
    if (String.isNotBlank(postal))
      parts.add('〒' + postal);
    if (String.isNotBlank(state))
      parts.add(state);
    if (String.isNotBlank(city))
      parts.add(city);
    if (String.isNotBlank(street))
      parts.add(street);
    return parts.isEmpty() ? null : String.join(parts, ' ');
  }

  // ─── メモ新規作成 ──────────────────────────────────────────
  @AuraEnabled
  public static Id createNote(String contactId, String title, String body) {
    ContentNote note = new ContentNote();
    note.Title = title;
    if (String.isNotBlank(body)) {
      note.Content = Blob.valueOf(body);
    }
    insert note;

    ContentDocumentLink cdl = new ContentDocumentLink();
    cdl.ContentDocumentId = note.Id;
    cdl.LinkedEntityId = contactId;
    cdl.ShareType = 'V';
    cdl.Visibility = 'AllUsers';
    insert cdl;

    return note.Id;
  }

  // ─── 電話発信: Task作成 ──────────────────────────────────────
  @AuraEnabled
  public static Id createCallTask(String contactId, String phoneNumber) {
    Task t = new Task(
      WhoId = contactId,
      Subject = '電話発信: ' + phoneNumber,
      Status = 'Completed',
      Priority = 'Normal',
      TaskSubtype = 'Call',
      CallType = 'Outbound',
      ActivityDate = Date.today()
    );
    insert t;
    return t.Id;
  }

  // ─── 電話発信: メモ更新 ──────────────────────────────────────
  @AuraEnabled
  public static void updateCallMemo(String taskId, String memo) {
    Task t = new Task(Id = taskId, Description = memo);
    update t;
  }
}