struct RouteTile: View {
    var body: some View {
        HStack(){
            VStack(alignment: .leading, spacing: 10){
                Text("Route_Name")
                Text("X_Stops")
            }
            Spacer()
            Image(systemName: "chevron.right")
        }.padding(.vertical, 5)
    }
}