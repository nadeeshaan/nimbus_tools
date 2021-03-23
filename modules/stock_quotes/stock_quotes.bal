import ballerina/io;
import ballerina/lang.runtime;
import ballerina/websocket as ws;

// function listen(string[] symbols) {
//     FutureSub[] futures = [];

//     foreach string symbol in symbols {
//         FinnHubTradesSubsriber fl = new (wsClient, 2);
//         future<()> f = start fl.subscribe(symbol);
//         futures.push({ft: f, subscriber: fl});
//     }

//     runtime:sleep(10);

//     foreach FutureSub item in futures {
//         item.subscriber.stop();
//         item.ft.cancel();
//     }
// }

// function abort() {

// }

// function update(string value) {
//     io:println(value);
// }

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

// function caller() returns error? {
//     string symbolName = "HITBTC:MGBTC";
//     string subscriptionMsg = string `{"type":"subscribe","symbol":"${symbolName}"}`;
//     // "{\"type\":\"subscribe\",\"symbol\":\"HITBTC:MGBTC\"}"
//     checkpanic wsClient->writeTextMessage(subscriptionMsg);

//     int x = 0;
//     while x < 2 {
//         string readTextMessage = check wsClient->readTextMessage();
//         io:println(readTextMessage);
//         x += 1;
//     }
// }

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
