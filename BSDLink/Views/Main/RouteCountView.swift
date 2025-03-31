struct RouteCountView: View {
    let count: Int
    
    var body: some View {
        HStack {
            Text("\(count) Routes")
            Spacer()
        }
        .frame(maxWidth: 355, alignment: .init(horizontal: .leading, vertical: .center))
    }
}