@isTest
private class StandardSetDemoControllerTest {
    static testMethod void testMethod1() {
        Test.StartTest();

        Test.setMock(HttpCalloutMock.class, new WebMock());
        StandardSetDemoController ssdCon = new StandardSetDemoController();
        ssdCon.getWrappers();
        ssdCon.first();
        ssdCon.last();
        ssdCon.previous();
        ssdCon.next();
        ssdCon.save();
        ssdCon.toggleAll();
        ssdCon.updateCount();
        ssdCon.go();
        ssdCon.pSize = 500;
        ssdCon.setPaSize();
        ssdCon.pPage = 1;
        ssdCon.gotoPage();      
        Test.StopTest();
    }
    @TestSetup
    static void setupData() {
        List<Account> insertAccList = new List<Account>();
        for(Integer i = 0; i < 200; i++) {
            Account acc = new Account();
            acc.Name = 'Test' + i;
            insertAccList.add(acc);
        }

        insert insertAccList;
    }
}