public class ObserverPatternTest {
    public static void main(String[] args) {
        StockMarket appleStock = new StockMarket("AAPL", 150.00);

        Observer mobileApp = new MobileApp("MyTrade Mobile");
        Observer webApp = new WebApp("TradeWeb Portal");

        appleStock.registerObserver(mobileApp);
        appleStock.registerObserver(webApp);

        System.out.println("Changing stock price to 155.00");
        appleStock.setPrice(155.00);

        appleStock.removeObserver(webApp);

        System.out.println("\nChanging stock price to 160.00");
        appleStock.setPrice(160.00);
    }
}
