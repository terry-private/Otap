//
//  LicensesView.swift
//  
//
//  Created by 若江照仁 on 2023/04/01.
//

import SwiftUI

struct LicensesView: View {
    var body: some View {
        List {
            ForEach(LicensesPlugin.licenses) { license in
                NavigationLink {
                    LicenseView(license: license)
                } label: {
                    Text(license.name)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
            }
        }
        .navigationBarTitle(L10n.LicensesView.navigationBarTitle)
    }
    
}

private extension LicensesView {
    struct LicenseView: View {
        let license: LicensesPlugin.License
        var body: some View {
            ScrollView {
                if let licenseText = license.licenseText {
                    ScrollView {
                        Text(licenseText)
                            .padding()
                    }
                } else {
                    Text("No License Found")
                }
            }
            .navigationTitle(license.name)
        }
    }
}

struct LicensesView_Previews: PreviewProvider {
    static var previews: some View {
        LicensesView()
    }
}
