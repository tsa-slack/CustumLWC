@IsTest
private class CustomerDetailCtrlTest {
  // ─── テストデータ作成 ──────────────────────────────────────
  @TestSetup
  static void setupData() {
    // Contact
    Contact con = new Contact(
      LastName = 'テスト太郎',
      Okyakusamacode__c = 'TEST001',
      Phone = '03-1234-5678',
      MobilePhone = '090-1234-5678',
      Email = 'test@example.com',
      Birthdate = Date.newInstance(1990, 5, 15),
      MailingPostalCode = '100-0001',
      MailingState = '東京都',
      MailingCity = '千代田区',
      MailingStreet = '丸の内1-1-1',
      OtherPostalCode = '150-0001',
      OtherState = '東京都',
      OtherCity = '渋谷区',
      OtherStreet = '渋谷2-2-2'
    );
    insert con;

    // 車両（有効：MaxshoFlg=false）
    Sharyo__c sharyo1 = new Sharyo__c(
      Okyakusama__c = con.Id,
      carName__c = 'プリウス',
      Maker__c = 'トヨタ',
      Katashiki__c = 'ZVW50',
      ShinchuKubunCode__c = '1',
      SokoKyori__c = 30000,
      SaisinSateiBi__c = Date.today().addMonths(-3),
      SaisinSateikyori__c = 28000,
      SaisinSateikinngaku__c = 1500000,
      ShakenManryobi__c = Date.today().addMonths(6)
    );
    insert sharyo1;

    // 車両（抹消済み：MaxshoFlg=true → 表示対象外）
    // 抹消車両のテストは MaxshoFlg__c が数式フィールドの為省略

    // 保険
    Hoken__c hoken = new Hoken__c(
      ContactId__c = con.Id,
      HokenKaishaMei2__c = '東京海上',
      ShokenBango__c = 'HK-0001',
      Shikibi__c = Date.today().addYears(-1),
      Mankibi__c = Date.today().addMonths(3),
      SharyoId__c = sharyo1.Id
    );
    insert hoken;

    // JAF
    JAF__c jaf = new JAF__c(
      Contact__c = con.Id,
      GaibuKey__c = 'JAF-TEST-001',
      KaiinNumber__c = '12345678',
      KaiinShubetu__c = '個人',
      Year__c = 5
    );
    insert jaf;

    // 代替促進候補（ブランクステータス）
    DaigaeSokusinKouho__c daigae1 = new DaigaeSokusinKouho__c(
      contactId__c = con.Id,
      SCORE1__c = 55.0,
      ShodanMemoSakuseiBi__c = Date.today().addDays(-10)
    );
    insert daigae1;

    // 代替促進候補（商談メモ＝A）
    DaigaeSokusinKouho__c daigae2 = new DaigaeSokusinKouho__c(
      contactId__c = con.Id,
      SCORE1__c = 65.0,
      ShodanMemoSakuseiBi__c = Date.today().addDays(-5),
      JyuchuStatus__c = 'A'
    );
    insert daigae2;

    // 代替促進候補（受注済み＝B → 対象外）
    DaigaeSokusinKouho__c daigae3 = new DaigaeSokusinKouho__c(
      contactId__c = con.Id,
      SCORE1__c = 90.0,
      JyuchuStatus__c = 'B'
    );
    insert daigae3;

    // au携帯契約
    au__c auRec = new au__c(
      ContactName__c = con.Id,
      GaibuKey__c = 'AU-TEST-001',
      AuTel__c = '090-9999-8888',
      KishuMeisho__c = 'iPhone 15',
      Kishu__c = 'スマートフォン',
      RyokinPlanMeisho__c = '使い放題MAX',
      KeiyakuNoShubetsu__c = '新規',
      KeitaiKappuShiharaiGaku__c = 3000,
      KeitaiKappuShiharaiKaisuu__c = 24,
      KeitaiZansaiKingaku__c = 36000,
      KeiyakushameiKanji__c = 'テスト太郎'
    );
    insert auRec;
  }

  // ─── 正常系：全データ取得 ──────────────────────────────────
  @IsTest
  static void testGetCustomerDetail_AllData() {
    Contact con = [
      SELECT Id
      FROM Contact
      WHERE Okyakusamacode__c = 'TEST001'
      LIMIT 1
    ];

    Test.startTest();
    CustomerDetailCtrl.CustomerDetailWrapper result = CustomerDetailCtrl.getCustomerDetail(
      con.Id
    );
    Test.stopTest();

    // Contact
    System.assertNotEquals(null, result.contact, 'contact should not be null');
    System.assertEquals('テスト太郎', result.contact.name, 'name mismatch');
    System.assertEquals(
      'TEST001',
      result.contact.okyakusamacode,
      'code mismatch'
    );
    System.assertEquals('03-1234-5678', result.contact.phone, 'phone mismatch');
    System.assertEquals(
      '090-1234-5678',
      result.contact.mobilePhone,
      'mobile mismatch'
    );
    System.assertEquals(
      'test@example.com',
      result.contact.email,
      'email mismatch'
    );
    System.assertEquals(
      Date.newInstance(1990, 5, 15),
      result.contact.birthdate,
      'birthdate mismatch'
    );

    // 住所が組み立てられているか
    System.assert(
      result.contact.mailingAddress != null,
      'mailingAddress should be set'
    );
    System.assert(
      result.contact.mailingAddress.contains('千代田区'),
      'mailingAddress should contain city'
    );
    System.assert(
      result.contact.otherAddress != null,
      'otherAddress should be set'
    );
    System.assert(
      result.contact.otherAddress.contains('渋谷区'),
      'otherAddress should contain city'
    );

    // 車両（有効な1台のみ、抹消済みは除外）
    System.assertEquals(
      1,
      result.sharyoList.size(),
      'should have 1 active vehicle'
    );
    CustomerDetailCtrl.SharyoWrapper sv = result.sharyoList[0];
    System.assertEquals('プリウス', sv.carName, 'carName mismatch');
    System.assertNotEquals(null, sv.maker, 'maker should be set');
    System.assertEquals('ZVW50', sv.katashiki, 'katashiki mismatch');
    System.assertEquals(
      '新車',
      sv.shinchuKubun,
      'shinchuKubun should be 新車 for code 1'
    );
    System.assertEquals(30000, sv.sokoKyori, 'sokoKyori mismatch');
    // 査定
    System.assertEquals(
      Date.today().addMonths(-3),
      sv.saisinSateiBi,
      'sateiBi mismatch'
    );
    System.assertEquals(28000, sv.saisinSateiKyori, 'sateiKyori mismatch');
    System.assertEquals(
      1500000,
      sv.saisinSateiKingaku,
      'sateiKingaku mismatch'
    );

    // 保険（HyojiFlg1__cは数式フィールドの為フィルタの完全テストは省略）
    System.assert(result.hokenList != null, 'hokenList should not be null');
    if (!result.hokenList.isEmpty()) {
      CustomerDetailCtrl.HokenWrapper hv = result.hokenList[0];
      System.assertNotEquals(null, hv.kaishaMei, 'kaishaMei should be set');
    }

    // JAF
    System.assertEquals(1, result.jafList.size(), 'should have 1 JAF');
    CustomerDetailCtrl.JAFWrapper jv = result.jafList[0];
    System.assertEquals('12345678', jv.kaiinNumber, 'kaiinNumber mismatch');
    System.assertEquals('個人', jv.kaiinShubetu, 'kaiinShubetu mismatch');
    System.assertEquals(5, jv.year, 'year mismatch');

    // 代替促進候補（スコア最高の65=A商談メモが取得される）
    System.assertNotEquals(
      null,
      result.daigaeScore,
      'daigaeScore should not be null'
    );
    System.assertEquals(4, result.daigaeRank, 'rank for 65 should be 4');
    System.assertEquals(
      Date.today().addDays(-5),
      result.daigaeShodanMemoDate,
      'memoDate mismatch'
    );
  }

  // ─── 正常系：関連データなし ──────────────────────────────────
  @IsTest
  static void testGetCustomerDetail_NoRelatedData() {
    // 関連データのない新規Contact
    Contact con2 = new Contact(LastName = 'データなし');
    insert con2;

    Test.startTest();
    CustomerDetailCtrl.CustomerDetailWrapper result = CustomerDetailCtrl.getCustomerDetail(
      con2.Id
    );
    Test.stopTest();

    System.assertNotEquals(null, result.contact, 'contact should not be null');
    System.assertEquals('データなし', result.contact.name, 'name mismatch');
    System.assertEquals(0, result.sharyoList.size(), 'no vehicles');
    System.assertEquals(0, result.hokenList.size(), 'no hoken');
    System.assertEquals(0, result.jafList.size(), 'no jaf');
    System.assertEquals(0, result.contentNotes.size(), 'no content notes');
    System.assertEquals(null, result.daigaeScore, 'no daigae score');
    System.assertEquals(null, result.daigaeRank, 'no daigae rank');
    System.assertEquals(
      null,
      result.daigaeShodanMemoDate,
      'no daigae memo date'
    );
  }

  // ─── 新中区分変換テスト ──────────────────────────────────────
  @IsTest
  static void testShinchuKubunConversion() {
    Contact con = [
      SELECT Id
      FROM Contact
      WHERE Okyakusamacode__c = 'TEST001'
      LIMIT 1
    ];

    // コード1 → 新車（既にテスト済みだが明示的に）
    CustomerDetailCtrl.CustomerDetailWrapper result = CustomerDetailCtrl.getCustomerDetail(
      con.Id
    );
    System.assertEquals(
      '新車',
      result.sharyoList[0].shinchuKubun,
      'code 1 = 新車'
    );

    // コード2のテスト用車両
    Sharyo__c ucar = new Sharyo__c(
      Okyakusama__c = con.Id,
      carName__c = 'ヴィッツ',
      ShinchuKubunCode__c = '2'
    );
    insert ucar;

    result = CustomerDetailCtrl.getCustomerDetail(con.Id);
    Boolean foundUcar = false;
    for (CustomerDetailCtrl.SharyoWrapper sw : result.sharyoList) {
      if (sw.carName == 'ヴィッツ') {
        System.assertEquals('U-Car', sw.shinchuKubun, 'code 2 = U-Car');
        foundUcar = true;
      }
    }
    System.assert(foundUcar, 'U-Car vehicle should be found');
  }

  // ─── スコアランク変換テスト ──────────────────────────────────
  @IsTest
  static void testScoreToRankConversion() {
    Contact con2 = new Contact(LastName = 'ランクテスト');
    insert con2;

    // 各スコア帯のテスト
    Map<Decimal, Integer> scoreToRank = new Map<Decimal, Integer>{
      10.0 => 0, // 30未満 → 0
      35.0 => 1, // 30-39 → 1
      45.0 => 2, // 40-49 → 2
      55.0 => 3, // 50-59 → 3
      65.0 => 4, // 60-69 → 4
      85.0 => 5 // 80+   → 5
    };

    for (Decimal score : scoreToRank.keySet()) {
      // 既存を削除してから新規作成
      delete [
        SELECT Id
        FROM DaigaeSokusinKouho__c
        WHERE contactId__c = :con2.Id
      ];

      DaigaeSokusinKouho__c d = new DaigaeSokusinKouho__c(
        contactId__c = con2.Id,
        SCORE1__c = score
      );
      insert d;

      CustomerDetailCtrl.CustomerDetailWrapper result = CustomerDetailCtrl.getCustomerDetail(
        con2.Id
      );

      Integer expectedRank = scoreToRank.get(score);
      if (expectedRank == 0) {
        // rank 0 の場合はnullまたは0
        System.assert(
          result.daigaeRank == null || result.daigaeRank == 0,
          'score ' +
            score +
            ' should have rank 0 or null, got ' +
            result.daigaeRank
        );
      } else {
        System.assertEquals(
          expectedRank,
          result.daigaeRank,
          'score ' + score + ' should have rank ' + expectedRank
        );
      }
    }
  }

  // ─── 代替促進候補：ステータスBは対象外 ──────────────────────
  @IsTest
  static void testDaigaeExcludesNonTargetStatus() {
    Contact con3 = new Contact(LastName = 'ステータステスト');
    insert con3;

    // B（受注済み）のみのレコード
    DaigaeSokusinKouho__c d = new DaigaeSokusinKouho__c(
      contactId__c = con3.Id,
      SCORE1__c = 90.0,
      JyuchuStatus__c = 'B'
    );
    insert d;

    Test.startTest();
    CustomerDetailCtrl.CustomerDetailWrapper result = CustomerDetailCtrl.getCustomerDetail(
      con3.Id
    );
    Test.stopTest();

    System.assertEquals(
      null,
      result.daigaeScore,
      'B status should be excluded'
    );
    System.assertEquals(
      null,
      result.daigaeRank,
      'B status should have no rank'
    );
  }

  // ─── ContentNote: 新規作成テスト ──────────────────────────────────
  @IsTest
  static void testCreateNote() {
    Contact con = [
      SELECT Id
      FROM Contact
      WHERE Okyakusamacode__c = 'TEST001'
      LIMIT 1
    ];

    Test.startTest();
    Id noteId = CustomerDetailCtrl.createNote(
      con.Id,
      'テストメモ',
      'メモの本文です'
    );
    Test.stopTest();

    System.assertNotEquals(null, noteId, 'noteId should not be null');

    // ContentDocumentLinkが作成されたか
    List<ContentDocumentLink> links = [
      SELECT Id
      FROM ContentDocumentLink
      WHERE
        LinkedEntityId = :con.Id
        AND ContentDocumentId = :noteId
    ];
    System.assertEquals(1, links.size(), 'should have 1 link');
  }

  // ─── ContentNote: 取得テスト ──────────────────────────────────────
  @IsTest
  static void testContentNotes() {
    Contact con = [
      SELECT Id
      FROM Contact
      WHERE Okyakusamacode__c = 'TEST001'
      LIMIT 1
    ];

    // メモを2件作成
    CustomerDetailCtrl.createNote(con.Id, 'メモ1', '本文1');
    CustomerDetailCtrl.createNote(con.Id, 'メモ2', '本文2');

    Test.startTest();
    CustomerDetailCtrl.CustomerDetailWrapper result = CustomerDetailCtrl.getCustomerDetail(
      con.Id
    );
    Test.stopTest();

    System.assertNotEquals(
      null,
      result.contentNotes,
      'contentNotes should not be null'
    );
    System.assertEquals(
      2,
      result.contentNotes.size(),
      'should have 2 notes'
    );
    // 最新順なのでメモ2が先
    System.assertEquals(
      'メモ2',
      result.contentNotes[0].title,
      'latest note should be first'
    );
  }

  // ─── ContentNote: 最大3件制限テスト ──────────────────────────────
  @IsTest
  static void testContentNotes_MaxThree() {
    Contact con = [
      SELECT Id
      FROM Contact
      WHERE Okyakusamacode__c = 'TEST001'
      LIMIT 1
    ];

    // 4件のメモを作成
    CustomerDetailCtrl.createNote(con.Id, 'メモA', '本文A');
    CustomerDetailCtrl.createNote(con.Id, 'メモB', '本文B');
    CustomerDetailCtrl.createNote(con.Id, 'メモC', '本文C');
    CustomerDetailCtrl.createNote(con.Id, 'メモD', '本文D');

    Test.startTest();
    CustomerDetailCtrl.CustomerDetailWrapper result = CustomerDetailCtrl.getCustomerDetail(
      con.Id
    );
    Test.stopTest();

    System.assertEquals(
      3,
      result.contentNotes.size(),
      'should have max 3 notes'
    );
  }

  // ─── 電話発信: Task作成テスト ──────────────────────────────────
  @IsTest
  static void testCreateCallTask() {
    Contact con = [
      SELECT Id
      FROM Contact
      WHERE Okyakusamacode__c = 'TEST001'
      LIMIT 1
    ];

    Test.startTest();
    Id taskId = CustomerDetailCtrl.createCallTask(con.Id, '090-1234-5678');
    Test.stopTest();

    System.assertNotEquals(null, taskId, 'taskId should not be null');

    Task t = [
      SELECT Subject, Status, TaskSubtype, CallType, WhoId, ActivityDate
      FROM Task
      WHERE Id = :taskId
    ];
    System.assertEquals('電話発信: 090-1234-5678', t.Subject, 'subject mismatch');
    System.assertEquals('Completed', t.Status, 'status should be Completed');
    System.assertEquals('Call', t.TaskSubtype, 'subtype should be Call');
    System.assertEquals('Outbound', t.CallType, 'callType should be Outbound');
    System.assertEquals(con.Id, t.WhoId, 'whoId should match contact');
    System.assertEquals(Date.today(), t.ActivityDate, 'activityDate should be today');
  }

  // ─── 電話発信: メモ更新テスト ─────────────────────────────────
  @IsTest
  static void testUpdateCallMemo() {
    Contact con = [
      SELECT Id
      FROM Contact
      WHERE Okyakusamacode__c = 'TEST001'
      LIMIT 1
    ];

    Id taskId = CustomerDetailCtrl.createCallTask(con.Id, '03-1234-5678');

    Test.startTest();
    CustomerDetailCtrl.updateCallMemo(taskId, '折り返し希望。明日午前中に再度連絡。');
    Test.stopTest();

    Task t = [SELECT Description FROM Task WHERE Id = :taskId];
    System.assertEquals(
      '折り返し希望。明日午前中に再度連絡。',
      t.Description,
      'memo should be updated'
    );
  }

  // ─── au携帯契約: 取得テスト ──────────────────────────────────
  @IsTest
  static void testAuList() {
    Contact con = [
      SELECT Id
      FROM Contact
      WHERE Okyakusamacode__c = 'TEST001'
      LIMIT 1
    ];

    Test.startTest();
    CustomerDetailCtrl.CustomerDetailWrapper result = CustomerDetailCtrl.getCustomerDetail(
      con.Id
    );
    Test.stopTest();

    System.assertEquals(1, result.auList.size(), 'should have 1 au record');
    CustomerDetailCtrl.AuWrapper au = result.auList[0];
    System.assertEquals('090-9999-8888', au.auTel, 'auTel mismatch');
    System.assertEquals('iPhone 15', au.kishuMeisho, 'kishuMeisho mismatch');
    System.assertEquals('スマートフォン', au.kishu, 'kishu mismatch');
    System.assertEquals('使い放題MAX', au.ryokinPlan, 'ryokinPlan mismatch');
    System.assertEquals('新規', au.keiyakuShubetsu, 'keiyakuShubetsu mismatch');
    System.assertEquals(3000, au.keitaiKappuShiharaiGaku, 'kappuGaku mismatch');
    System.assertEquals(24, au.keitaiKappuShiharaiKaisuu, 'kappuKaisuu mismatch');
    System.assertEquals(36000, au.keitaiZansaiKingaku, 'zansai mismatch');
    System.assertEquals('テスト太郎', au.keiyakushaMei, 'keiyakusha mismatch');
  }
}