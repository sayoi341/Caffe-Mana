import SwiftUI

struct Loading: View {
    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()
            VStack{
                SVGImage(name: "loading-icon").frame(width:275,height:440);
                Text("Caffeine")
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                Text("Manager")
                    .font(.title)
                    .fontWeight(.semibold)
                    .foregroundColor(Color(red:0.52, green:0.91, blue:0.38, opacity: 1))
            }
        }
    }
}

struct Loading_Previews: PreviewProvider {
    static var previews: some View {
        Loading()
    }
}
