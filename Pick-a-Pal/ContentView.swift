import SwiftUI


struct ContentView: View {
	@State private var names: [String] = ["Elisha", "Andre", "Jasmine", "Po-Chun"]
	@State private var nameToAdd = ""
	@State private var pickedName = ""
	@State private var shouldRemovePickedName = false
	@State private var showAlert = false
	
	var body: some View {
		VStack {
			VStack(spacing: 8) {
				Image(systemName: "person.3.sequence.fill")
					.foregroundStyle(.tint)
					.symbolRenderingMode(.hierarchical)
				Text("Pick-a-Pal")
			}
			.font(.title)
			.bold()
			
			Text(pickedName.isEmpty ? " " : pickedName)
				.font(.title2)
				.bold()
				.foregroundStyle(.tint)
			
			List {
				ForEach(names, id: \.description) { name in
					Text(name)
				}
			}
			.clipShape(RoundedRectangle(cornerRadius: 8))
			
			TextField("Add Name", text: $nameToAdd)
				.autocorrectionDisabled()
				.onSubmit {
					let trimmedName = nameToAdd.trimmingCharacters(in: .whitespacesAndNewlines)
					if !trimmedName.isEmpty {
						if !names.contains(trimmedName) {
							names.append(nameToAdd)
							nameToAdd = ""
						} else {
							showAlert = true
						}
					}
				}
				.alert("Error", isPresented: $showAlert) {
					Button("OK", role: .cancel) {}
				} message: {
					Text("Name already exists.")
				}
			
			Divider()  // Adds a line between the TextField and the Button
			
			Toggle("Remove when picked", isOn: $shouldRemovePickedName)
			
			Button {
				if let randomName = names.randomElement() {
					pickedName = randomName
					
					if shouldRemovePickedName {
						names.removeAll { $0 == randomName }
						// $0 represents the first argument passed
					}
				} else {
					pickedName = ""
				}
			} label: {
				Text("Pick Random Name")
					.padding(.vertical, 6)
					.padding(.horizontal, 8)
			}
			.buttonStyle(.borderedProminent)
			.font(.headline)
		}
		.padding()
	}
}


#Preview {
	ContentView()
}

