import Foundation

struct DrinkData {
    var id:Int;
    var name: String;
    var cafeine: Int;
    var price: Int;
    var volume: Int;
    var fileName: String;
    
    init(id: Int, name: String, cafeine: Int, price: Int, volume: Int, fileName: String) {
        self.id = id
        self.name = name
        self.cafeine = cafeine
        self.price = price
        self.volume = volume
        self.fileName = fileName
    }
    
}
