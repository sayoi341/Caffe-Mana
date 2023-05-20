import Foundation

struct DrinkData:Equatable {
    var name: String;
    var cafeine: Int;
    var price: Int;
    var volume: Int;
    var fileName: String;
    
    init(name: String, cafeine: Int, price: Int, volume: Int, fileName: String) {
        self.name = name
        self.cafeine = cafeine
        self.price = price
        self.volume = volume
        self.fileName = fileName
    }
    
}
