@isTest
private class StandardSetDemoControllerTest {
    static testMethod void testSetPageSize() {

        Test.StartTest();

        Test.setMock(HttpCalloutMock.class, new WebMock());
        StandardSetDemoController ssdCon = new StandardSetDemoController();
        ssdCon.getWrappers();  
        ssdCon.pSize = 10;
        ssdCon.setPaSize();
        List<StandardSetDemoController.Wrapper> wList = ssdCon.getWrappers();

        Test.StopTest();

        System.assertEquals(wList.size(), 10);
        System.assertEquals(ssdCon.con.getHasPrevious(), false);
    }

    static testMethod void testSetPage() {

        Test.StartTest();

        Test.setMock(HttpCalloutMock.class, new WebMock());
        StandardSetDemoController ssdCon = new StandardSetDemoController();
        ssdCon.getWrappers();  
        ssdCon.pSize = 10;
        ssdCon.setPaSize();

        ssdCon.pPage = 20;
        ssdCon.gotoPage();
        List<StandardSetDemoController.Wrapper> wList = ssdCon.getWrappers();

        Test.StopTest();
        
        System.assertEquals(wList.size(), 10);
        System.assertEquals(ssdCon.con.getHasNext(), false);
    }

    static testMethod void testNext() {

        Test.StartTest();

        Test.setMock(HttpCalloutMock.class, new WebMock());
        StandardSetDemoController ssdCon = new StandardSetDemoController();
        ssdCon.getWrappers();  
        ssdCon.pSize = 90;
        ssdCon.setPaSize();

        Test.StopTest();
        System.assertEquals(ssdCon.getWrappers().size(), 90);
        System.assertEquals(ssdCon.currentPageNo, 1);
        ssdCon.next();
        System.assertEquals(ssdCon.getWrappers().size(), 90);
        System.assertEquals(ssdCon.currentPageNo, 2);
        ssdCon.next();
        System.assertEquals(ssdCon.getWrappers().size(), 20);
        System.assertEquals(ssdCon.currentPageNo, 3);
        ssdCon.first();
        System.assertEquals(ssdCon.getWrappers().size(), 90);
        System.assertEquals(ssdCon.currentPageNo, 1);
    }

    static testMethod void testPrevious() {

        Test.StartTest();

        Test.setMock(HttpCalloutMock.class, new WebMock());
        StandardSetDemoController ssdCon = new StandardSetDemoController();
        ssdCon.getWrappers();  
        ssdCon.pSize = 90;
        ssdCon.setPaSize();
        ssdCon.last();
        Test.StopTest();

        System.assertEquals(ssdCon.getWrappers().size(), 20);
        ssdCon.previous();
        System.assertEquals(ssdCon.getWrappers().size(), 90);
        ssdCon.previous();
        System.assertEquals(ssdCon.getWrappers().size(), 90);
    }

    static testMethod void testCheck() {

        Test.StartTest();

        Test.setMock(HttpCalloutMock.class, new WebMock());
        StandardSetDemoController ssdCon = new StandardSetDemoController();
        ssdCon.getWrappers();  
        ssdCon.pSize = 90;
        ssdCon.setPaSize();
        ssdCon.sortOrderKeep = Schema.Account.Name.getDescribe().getLabel() + '△';
        ssdCon.sort();
        Test.StopTest();

        System.assertEquals(ssdCon.getWrappers().size(), 90);
        System.assertEquals(ssdCon.getWrappers()[0].valueList[1], 'Test000');
        ssdCon.getWrappers()[0].isChecked = true;
        ssdCon.next();
        ssdCon.getWrappers();
        ssdCon.previous();
        System.assertEquals(ssdCon.getWrappers()[0].isChecked, true);
        System.assertEquals(ssdCon.getWrappers()[0].valueList[1], 'Test000');
        System.assertEquals(ssdCon.selectedCount, 1);

        ssdCon.last();
        System.assertEquals(ssdCon.getWrappers()[19].valueList[1], 'Test199');
        ssdCon.getWrappers()[19].isChecked = true;
        ssdCon.previous();
        ssdCon.getWrappers();
        ssdCon.next();
        System.assertEquals(ssdCon.getWrappers()[19].isChecked, true);
        System.assertEquals(ssdCon.getWrappers()[19].valueList[1], 'Test199');
        System.assertEquals(ssdCon.selectedCount, 2);

        ssdCon.first();
        System.assertEquals(ssdCon.getWrappers()[0].isChecked, true);
        System.assertEquals(ssdCon.getWrappers()[0].valueList[1], 'Test000');
        System.assertEquals(ssdCon.selectedCount, 2);

        ssdCon.last();
        System.assertEquals(ssdCon.getWrappers()[19].isChecked, true);
        System.assertEquals(ssdCon.getWrappers()[19].valueList[1], 'Test199');
        System.assertEquals(ssdCon.selectedCount, 2);

    }
    static testMethod void testSort() {
        Test.StartTest();

        Test.setMock(HttpCalloutMock.class, new WebMock());
        StandardSetDemoController ssdCon = new StandardSetDemoController();
        ssdCon.getWrappers();  
        ssdCon.pSize = 90;
        ssdCon.setPaSize();
        ssdCon.getWrappers(); 
        ssdCon.sortOrderKeep = Schema.getGlobalDescribe().get('Account').getDescribe().fields.getMap().get('Name').getDescribe().getLabel() + '△';
        ssdCon.sort();
        ssdCon.getWrappers();
        Test.StopTest();

        System.assertEquals(ssdCon.getWrappers()[0].valueList[1], 'Test000');
        ssdCon.getWrappers()[0].isChecked = true;

        ssdCon.last();
        System.assertEquals(ssdCon.getWrappers()[19].valueList[1], 'Test199');
        System.assertEquals(ssdCon.getWrappers()[19].isChecked, false);
        System.assertEquals(ssdCon.selectedCount, 1);

        ssdCon.getWrappers()[19].isChecked = true;
        ssdCon.first();
        System.assertEquals(ssdCon.getWrappers()[0].valueList[1], 'Test000');
        System.assertEquals(ssdCon.getWrappers()[0].isChecked, true);
        System.assertEquals(ssdCon.selectedCount, 2);

        //ssdCon.sortOrderKeep = Schema.getGlobalDescribe().get('Account').getDescribe().fields.getMap().get('Name').getDescribe().getLabel() + '▽';
        ssdCon.sortOrderKeep = Schema.Account.Name.getDescribe().getLabel() + '▽';
        ssdCon.sort();

        System.assertEquals(ssdCon.getWrappers()[0].valueList[1], 'Test199');
        System.assertEquals(ssdCon.getWrappers()[0].isChecked, true);
        System.assertEquals(ssdCon.selectedCount, 2); 

        ssdCon.last();

        System.assertEquals(ssdCon.getWrappers()[19].valueList[1], 'Test000');
        System.assertEquals(ssdCon.getWrappers()[19].isChecked, true);
        System.assertEquals(ssdCon.selectedCount, 2);
    }
    static testMethod void testToggleAll() {

        Test.StartTest();

        Test.setMock(HttpCalloutMock.class, new WebMock());
        StandardSetDemoController ssdCon = new StandardSetDemoController();
        ssdCon.getWrappers();
        ssdCon.toggleAll();
        ssdCon.toggleAll();
        Test.StopTest();
    }

    static testMethod void testOthers() {

        Test.StartTest();

        Test.setMock(HttpCalloutMock.class, new WebMock());
        StandardSetDemoController ssdCon = new StandardSetDemoController();
        ssdCon.getWrappers(); //1
        List<SelectOption> listViewList = ssdCon.con.getListViewOptions();
        ssdCon.con.setFilterId(listViewList[1].getValue());
        ssdCon.go();
        ssdCon.updateCount();
        ssdCon.save();
        ssdCon.pSize = 0;
        ssdCon.setPaSize();
        ssdCon.pSize = 1001;
        ssdCon.setPaSize();  
        ssdCon.pPage = 0;
        ssdCon.gotoPage();
        ssdCon.pPage = 1000;
        ssdCon.gotoPage();

        Test.StopTest();
    }

    @TestSetup
    static void setupData() {
        List<Account> insertAccList = new List<Account>();
        for(Integer i = 0; i < 200; i++) {
            Account acc = new Account();
            acc.Name = 'Test' + String.valueOf(i).leftPad(3,'0');
            insertAccList.add(acc);
        }

        insert insertAccList;
    }
}