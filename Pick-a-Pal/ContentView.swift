import SwiftUI


struct ContentView: View {
	@State private var names: [String] = ["Elisha", "Andre", "Jasmine", "Po-Chun"]
	@State private var nameToAdd = ""
	@State private var pickedName = ""
	@State private var shouldRemovePickedName = false
	
	var body: some View {
		VStack {
			Text(pickedName.isEmpty ? " " : pickedName)
			
			List {
				ForEach(names, id: \.description) { name in
					Text(name)
				}
			}
			
			TextField("Add Name", text: $nameToAdd)
				.autocorrectionDisabled()
				.onSubmit {
					if !nameToAdd.isEmpty {
						names.append(nameToAdd)
						nameToAdd = ""
					}
				}
			
			Divider()  // Adds a line between the TextField and the Button
			
			Toggle("Remove when picked", isOn: $shouldRemovePickedName)
			
			Button("Pick Random Name") {
				if let randomName = names.randomElement() {
					pickedName = randomName
					
					if shouldRemovePickedName {
						names.removeAll { $0 == randomName }
						// $0 represents the first argument passed
					}
				} else {
					pickedName = ""
				}
			}
		}
		.padding()
	}
}


#Preview {
	ContentView()
}

