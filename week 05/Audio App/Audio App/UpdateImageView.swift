import SwiftUI

struct UpdateImageView: View {
    var action: String // "Update" or "Add"
    var id: UUID
    
    @State var urlStr:String = ""
    @State var title:String = ""
    @State var artist:String = ""
    @State var songUrl:String = ""
    
    @State var uiImage:UIImage?
    
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var document:Document
    
    var body: some View {
        VStack {
            ZStack {
                Image(urlStr)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                if let uiImage {
                    Image(uiImage: uiImage)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                }
                HStack {
                    Button("Update") {
                        print("UpdateImageView Update")
                        document.updateItem(id: id, urlStr: urlStr, title: title,
                                            artist: artist, songUrl: songUrl)
                        dismiss()
                    }
                    Spacer()
                    Button("Delete") {
                        document.deleteItem(id: id)
                        dismiss();
                    }
                }.padding(10)
                Form {
                    TextField("Album Image URL", text: $urlStr)
                        .textInputAutocapitalization(.never)
                        .disableAutocorrection(true)
                    TextField("Song Title", text: $title)
                        .disableAutocorrection(true)
                    TextField("Artist", text: $artist)
                        .disableAutocorrection(true)
                    TextField("Song Link", text: $songUrl)
                        .textInputAutocapitalization(.never)
                        .disableAutocorrection(true)
                }
            }
            .task {
                uiImage =  await imageFor(string: urlStr)
            }
        }
    }
    
    struct UpdateImageView_Previews: PreviewProvider {
        static var previews: some View {
            UpdateImageView(action: "action", id: UUID())
        }
    }
}
