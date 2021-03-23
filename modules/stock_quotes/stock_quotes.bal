import ballerina/io;
import ballerina/lang.runtime;
import ballerina/websocket as ws;

class FinnHubRTFeed {
    private FutureSub[] futures;
    private ws:Client wsClient;

    function init(ws:Client wsClient) {
        self.futures = [];
        self.wsClient = wsClient;
    }

    function listen(string[] symbols) {
        foreach string symbol in symbols {
            FinnHubTradesSubscriber fl = new (self.wsClient, 2);
            future<()> f = start fl.subscribe(symbol);
            self.futures.push({ft: f, subscriber: fl});
        }
    }

    function abort() {
        foreach FutureSub item in self.futures {
            item.subscriber.stop();
            item.ft.cancel();
        }
    }
}

class FinnHubTradesSubscriber {
    private ws:Client wsClient;
    private decimal pollInterval;
    private boolean proceed = false;

    function init(ws:Client wsClient, decimal pollInterval) {
        self.wsClient = wsClient;
        self.pollInterval = pollInterval;
    }

    public function subscribe(string symbolName) {
        string subscriptionMsg = string `{"type":"subscribe","symbol":"${symbolName}"}`;
        ws:Error? resp = self.wsClient->writeTextMessage(subscriptionMsg);
        if resp is ws:Error {
            return;
        }
        self.proceed = true;
        while self.proceed {
            io:println("Poll for: " + symbolName);
            string|ws:Error response = self.wsClient->readTextMessage();
            if (response is ws:Error) {
                self.stop();
                break;
            } else {
                json jsonResult = response.toJson();
                json|error unionResult = jsonResult.'type;
                if (unionResult is error) {
                    self.stop();
                } else {
                    
                }
            }

            io:println(response);
            runtime:sleep(self.pollInterval);
        }
    }

    public function stop() {
        io:println("interrupted!");
        self.proceed = false;
    }
}
