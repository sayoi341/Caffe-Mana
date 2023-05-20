import SwiftUI

struct VendingMachineButton: View {
    
    var drinkId: String
    var d: DrinkData?
    var height: CGFloat
    var width: CGFloat
    
    init(drinkId: String, height:CGFloat, width: CGFloat) {
        self.drinkId = drinkId
        self.d = drinkData[drinkId]
        if width * 3.3 <= height{
            self.width = width
            self.height = width*3.3
        } else {
            self.width = height/3.3
            self.height = height
        }
    }
    

    
    var body: some View {
        if let drink = d {
            GeometryReader {geoOutline in
                VStack(spacing: 0) {
                    SVGImage(name: drink.fileName)
                        .frame(width:geoOutline.size.width*0.9,height:geoOutline.size.height*0.7);
                    Spacer()
                    VStack(spacing: 0){
                        Rectangle()
                            .fill(Color(red: 0.27, green: 0.7, blue: 0.85))
                            .frame(width: geoOutline.size.width ,height: geoOutline.size.height*0.05)
                        ZStack{
                            Rectangle()
                                .fill(Color(red: 0.8, green: 0.9, blue: 0.95))
                                .frame(width: geoOutline.size.width,height: geoOutline.size.height*0.2)
                            ZStack{
                                Rectangle()
                                    .fill(Color(red: 1.0, green: 0.785, blue: 0.34))
                                    .frame(width: geoOutline.size.width*0.8, height: geoOutline.size.height*0.15)
                                    .cornerRadius(5)
                                Text(drink.name)
                                    .font(.caption)
                                    .truncationMode(.tail)
                                    .frame(width: geoOutline.size.width*0.8, height: geoOutline.size.height*0.15)
                                    .foregroundColor(Color.black)
                                
                            }
                        }.frame(width: geoOutline.size.width, height: geoOutline.size.height*0.2)
                    }
                    .frame(width: geoOutline.size.width, height: geoOutline.size.height*0.25)
                    .cornerRadius(10)
                }
            }.frame(width: width, height: height)

        } else {
            Text("error")
        }
    }
}

struct VendingMachineButton_Previews: PreviewProvider {
    static var previews: some View {
        VendingMachineButton(drinkId: "m10",height: 300, width: 90)
    }
}
