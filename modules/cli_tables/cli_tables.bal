import ballerina/io;

public function hello() {
    io:println("Hello World!");
}

public function print(string[] headers, map<string>[] valueMap) returns error? {
    io:println("++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++");
    io:println("+++++++++++++++++++++++++ ++++++++++++++++++++++++++++++ +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++");
    io:println("++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++");


    // valueMap.entries().forEach(function ([string, string] pair) {

    // });

    int length = 0;
    string header = "+ ".'join('join(" + ", headers)).'join(" +");
    // headers.forEach(function (string value) {
    //     string:j
    // })
    
}

function 'join(string delemiter, string[] strs) returns string {
    string joined = "";
    foreach int counter in 0 ... strs.length() {
        if counter == strs.length() - 1 {
            joined = joined.'join(strs[counter]);
            continue;
        }
        joined = joined.'join(delemiter, strs[counter]);
    }

    return joined;
}