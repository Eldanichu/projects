extends Node
class_name FileOperator


func setup():
    pass


func read_file() -> JSONParseResult:
    var json = JSON.parse('{}');
    return json
    
func save_file() -> bool:
    
    return false;

