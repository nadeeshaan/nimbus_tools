import ballerina/io;
import ballerina/regex;
import ballerina/websocket as ws;

// import ballerina/websocket as ws;

public function main() {
    io:println("Welcome to Nimbus Stock Quote Tool!");
    string symbolNames = io:readln("Enter Comma Separated Symbol Names\n>:");
    string[] symbolList = regex:split(symbolNames, ",");

    io:println("Press ctrl+c to exit");
    ws:Client wsClient = checkpanic new ("wss://ws.finnhub.io/?token=c1co0hn48v6vbcpf6010");
    FinnHubRTFeed rtFeed = new(wsClient);
    rtFeed.listen(symbolList);

    // string respond = io:readln("\n>:");
    // if respond.equalsIgnoreCaseAscii("q") {
    //     rtFeed.abort();
    // }
}