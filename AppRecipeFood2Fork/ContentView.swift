//
//  ContentView.swift
//  AppRecipeFood2Fork
//
//  Created by Renato on 10/06/24.
//

import SwiftUI

struct ContentView: View {

	@State private var recipeName: String = ""
	@State private var recipes: [Recipe] = []

	let recipeClient = RecipeClient()

    var body: some View {
		VStack{
			TextField("Enter name", text: $recipeName)
				.textFieldStyle(.roundedBorder)
				.onSubmit { //sempre que voce pressiona a tecla enter
					Task {
						do {
							recipes = try await recipeClient.searchRecipe(recipeName)
						} catch {
							print(error.localizedDescription)
						}
					}
				}
			List(recipes) { recipe in
				HStack {
					AsyncImage(url: recipe.featuredImage) { image in
						image
							.resizable()
							.clipShape(RoundedRectangle(cornerRadius: 25.0, style: .continuous))
							.frame(width: 100, height: 100)
					} placeholder: {
						ProgressView("Loading...")
					}
					Text(recipe.title)
				}
			}
		}
		.padding()
    }
}

#Preview {
    ContentView()
}
