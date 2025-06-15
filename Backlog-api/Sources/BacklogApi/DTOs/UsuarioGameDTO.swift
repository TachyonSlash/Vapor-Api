import Vapor
import Foundation

struct UsuarioGameDTO: Content {
    var id: UUID?
    var usuarioId: UUID
    var juegoId: UUID
    var status: String
    var review: String?
    var rating: Double?
    var fechaAgregado: Date?
}