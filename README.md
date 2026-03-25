# ACRM お客様詳細ビュー (Customer Detail View)

Salesforce Lightning Web Component (LWC) によるお客様情報統合ダッシュボード。  
Contact レコードに紐づく車両・保険・JAF・メモ情報を一画面に集約表示します。

---

## システム構成

### アーキテクチャ概要

```
┌─────────────────────────────────────────────────────────┐
│                  Salesforce Platform                     │
│                                                         │
│  ┌──────────────────────┐   ┌────────────────────────┐  │
│  │      FlexiPage       │   │  Contact Record Page   │  │
│  │ CustomerDetailPage   │   │                        │  │
│  │  (AppPage)           │   │  customerDetailNav     │  │
│  │                      │   │  Button (モバイル専用)  │  │
│  │  ┌────────────────┐  │   └──────────┬─────────────┘  │
│  │  │ customerDetail │  │              │ Navigate       │
│  │  │    (LWC)       │◄─┼──────────────┘                │
│  │  └───────┬────────┘  │                               │
│  └──────────┼───────────┘                               │
│             │ @AuraEnabled                              │
│  ┌──────────▼───────────┐                               │
│  │  CustomerDetailCtrl  │                               │
│  │     (Apex)           │                               │
│  └──────────┬───────────┘                               │
│             │ SOQL                                      │
│  ┌──────────▼──────────────────────────────────────┐    │
│  │  Salesforce Objects                             │    │
│  │  Contact / Sharyo__c / Hoken__c / JAF__c        │    │
│  │  DaigaeSokusinKouho__c / ContentNote            │    │
│  └─────────────────────────────────────────────────┘    │
└─────────────────────────────────────────────────────────┘
```

---

### コンポーネント一覧

| 種別 | 名前 | 説明 |
|------|------|------|
| **LWC** | `customerDetail` | メインコンポーネント。お客様・車両・保険等の統合ビュー |
| **LWC** | `customerDetailNavButton` | Contact レコードページ用ナビゲーションボタン（モバイル専用） |
| **Apex** | `CustomerDetailCtrl` | データ取得・メモ作成コントローラ |
| **Apex** | `CustomerDetailCtrlTest` | テストクラス |
| **FlexiPage** | `CustomerDetailPage` | AppPage（customerDetail を配置） |

---

### Salesforce オブジェクト依存関係

| オブジェクト | 用途 |
|-------------|------|
| `Contact` | お客様基本情報（氏名、電話、メール、住所等） |
| `Sharyo__c` | 車両情報（基本・点検・査定・割賦・タイヤ・TC） |
| `Hoken__c` | 保険情報（車両紐づき / 未紐づき） |
| `JAF__c` | JAF会員情報 |
| `DaigaeSokusinKouho__c` | 代替促進候補（ランク・スコア） |
| `ContentNote` | メモ（最新3件表示 + 新規作成） |

---

### ファイル構成

```
force-app/main/default/
├── classes/
│   ├── CustomerDetailCtrl.cls          # Apex コントローラ
│   └── CustomerDetailCtrlTest.cls      # テストクラス
├── lwc/
│   ├── customerDetail/
│   │   ├── customerDetail.html         # テンプレート
│   │   ├── customerDetail.js           # ロジック（データ変換・ゲッター）
│   │   ├── customerDetail.css          # SLDS カスタムスタイル
│   │   └── customerDetail.js-meta.xml  # メタデータ (lightning__AppPage)
│   └── customerDetailNavButton/
│       ├── customerDetailNavButton.html # モバイル専用ボタン
│       ├── customerDetailNavButton.js   # ナビゲーション処理
│       └── customerDetailNavButton.js-meta.xml
└── flexipages/
    └── CustomerDetailPage.flexipage-meta.xml
```

---

### 画面構成（customerDetail）

```
┌─────────────────────────────────────────────────┐
│  ページヘッダー                                  │
│  [アイコン] お客様名  #コード  カナ  ランク★     │
├──────────────────────────┬──────────────────────┤
│  お客様基本情報           │  メモ（最新3件）      │
│  性別/年齢/生年月日      │  [+新規追加]          │
│  電話/携帯/メール        │                      │
│  住所/担当者 etc.        │                      │
├──────────────────────────┴──────────────────────┤
│  車両カード × N台                                │
│  ┌─────────────────────────────────────────┐    │
│  │ [車名] [ナンバー]           [SS][種別]  │    │
│  │ ┌────┬────┬────┬────┬────┬─────┬───┐   │    │
│  │ │基本│点検│査定│保険│割賦│ﾀｲﾔ │TC │   │    │
│  │ └────┴────┴────┴────┴────┴─────┴───┘   │    │
│  │  (タブ内容)                             │    │
│  └─────────────────────────────────────────┘    │
├─────────────────────────────────────────────────┤
│  保険情報（車両未紐づき） │  JAF情報             │
└─────────────────────────────────────────────────┘
```

---

### 車両タブ詳細

| タブ | 表示項目 |
|------|----------|
| **基本** | メーカー、型式、新中区分、軽区分、走行距離、経過年数、初度登録、MP名称 |
| **点検** | 車検満了日、点検種別、点検予定日、誘致ステータス、残日数 |
| **査定** | 最新査定日、査定走行距離、査定金額 |
| **保険** | 保険会社、証券番号、始期日、満期日、等級、契約区分 |
| **割賦** | 元金、回数、毎月支払額、完済予定日、完済区分、満了まで |
| **タイヤ** | 夏/冬タイヤ溝残量（4輪）、入力日 |
| **TC** | 保険加入、商品名、満期日、契約サービス、契約日、満了日、料金プラン、通信機器 |

---

### UI 機能

- **レスポンシブ対応**: `FORM_FACTOR` によるモバイル/デスクトップ自動切替
-  **tel: / mailto: リンク**: 電話番号・メールアドレスをタップで発信/メーラー起動
- **色分けアラート**: 残日数・タイヤ溝に応じた4段階カラー（🟢OK / 🟡注意 / 🟠警告 / 🔴危険）
- **バッジ表示**: SS車両、車両種別、代替ランク★、商談メモ日付
- **タブデータ欠損表示**: 査定・保険データ未登録時に 🔴 マーク
- **メモ管理**: ContentNote の閲覧（最新3件）+ モーダルによる新規作成

---

## デプロイ

### 環境

| 環境 | Org Alias | 用途 |
|------|-----------|------|
| Sandbox | `acrm-sandbox` | 開発・テスト |
| Production | `acrm-prod` | 本番 |

### デプロイコマンド

```bash
# Sandbox
sf project deploy start --source-dir force-app/main/default/lwc/customerDetail --target-org acrm-sandbox --wait 10

# Production
sf project deploy start --source-dir force-app/main/default/lwc/customerDetail --target-org acrm-prod --wait 10

# 全コンポーネント一括
sf project deploy start --source-dir force-app --target-org acrm-sandbox --wait 10
```

### テスト実行

```bash
sf apex run test --class-names CustomerDetailCtrlTest --target-org acrm-sandbox --result-format human --wait 10
```

---

## 開発情報

| 項目 | 値 |
|------|-----|
| Source API Version | 64.0 |
| LWC API Version | 59.0 |
| プロジェクト名 | CustumLWC |
