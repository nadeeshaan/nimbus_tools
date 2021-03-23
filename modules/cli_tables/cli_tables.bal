import ballerina/io;

// todo: This is still WIP
public function hello() {
    io:println("Hello World!");
}

public function print(string[] headers, map<string>[] valueMap) returns error? {
    int length = 0;
    string header = "+ ".'join('join(" + ", headers)).'join(" +");
    io:println(nCopies("+", header.length()));
    io:println(header);
    io:println(nCopies("+", header.length()));
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

function nCopies(string toCopy, int number) returns string {
    string result = "";
    foreach int counter in 0 ... number {
        result = result.'join(toCopy);
    }

    return result;
}