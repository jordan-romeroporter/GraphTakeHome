
import SwiftUI
import Charts
import Foundation

struct ChartView<Header: View, Content: View, Footer: View>: View {
    let header: Header?
    let content: Content
    let footer: Footer?
    
    init(@ViewBuilder content: () -> Content, footer: (() -> Footer)? = nil, header: (() -> Header)? = nil) {
        self.content = content()
        self.footer = footer?()
        self.header = header?()
    }
    
    var body: some View {
        VStack(spacing: 0) {
            header
            content
            footer
        }
    }
}

extension ChartView where Footer == EmptyView, Header == EmptyView {
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
        self.footer = nil
        self.header = nil
    }
}

extension ChartView where Footer == EmptyView {
    init(@ViewBuilder content: () -> Content,
         @ViewBuilder header: () -> Header) {
        self.content = content()
        self.header = header()
        self.footer = nil
    }
}

extension ChartView where Header == EmptyView {
    init(@ViewBuilder content: () -> Content,
         @ViewBuilder footer: () -> Footer) {
        self.content = content()
        self.footer = footer()
        self.header = nil
    }
}
