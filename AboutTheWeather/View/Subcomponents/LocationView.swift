import SwiftUI

struct LocationView: View {
    @EnvironmentObject var viewModel: WeatherViewModel

    var body: some View {
        VStack(spacing: -15) {
            Text(viewModel.locationData.locality)
                .bold()
                .foregroundColor(.white)
                .font(.system(size: 36))
                .padding()
            if let urlString = viewModel.locationData.iconUrlString {
                AsyncImage(url: URL(string: urlString)) { image in
                    image
                        .renderingMode(.original)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                } placeholder: {}
                .frame(width: 220, height: 220, alignment: .center)
            }
            Text(viewModel.locationData.currentTemp)
                .bold()
                .foregroundColor(.white)
                .font(.system(size: 90))
                .padding()

            Text(viewModel.locationData.currentConditions)
                .bold()
                .foregroundColor(.white)
                .font(.system(size: 45))
                .padding()
        }
    }
}

struct HeaderView_Previews: PreviewProvider {
    static var previews: some View {
        LocationView()
    }
}
