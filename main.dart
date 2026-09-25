import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart'; // Abre WhatsApp y Facebook real

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CotizadorPinatas(),
    );
  }
}
class CotizadorPinatas extends StatefulWidget {
  const CotizadorPinatas({super.key});

  @override
  State<CotizadorPinatas> createState() => _CotizadorPinatasState();
}

class _CotizadorPinatasState extends State<CotizadorPinatas> {
  // 1. Controladores generales con tus datos comerciales reales oficiales
  final TextEditingController _pinataController = TextEditingController();
  final TextEditingController _clienteController = TextEditingController();
  final TextEditingController _telNegocioController = TextEditingController(text: "2321244601"); 
  final TextEditingController _waNegocioController = TextEditingController(text: "2321244601");  
  // Tu link oficial directo de internet que me proporcionaste
  final TextEditingController _fbNegocioController = TextEditingController(
    text: "https://facebook.com"
  ); 
  final TextEditingController _dirController = TextEditingController(
    text: "1ra privada de máximino Ávila Camacho colonia centro san José acateno puebla, c.p 73590"
  );
  // 2. Rejilla de dinero para materiales
  final TextEditingController _cartonController = TextEditingController(text: "0");
  final TextEditingController _periodicoController = TextEditingController(text: "0");
  final TextEditingController _rafiaController = TextEditingController(text: "0");
  final TextEditingController _siliconController = TextEditingController(text: "0");
  final TextEditingController _harinaController = TextEditingController(text: "0");
  final TextEditingController _crepeController = TextEditingController(text: "0");
  final TextEditingController _cintaController = TextEditingController(text: "0");
  final TextEditingController _fomiController = TextEditingController(text: "0");
  final TextEditingController _impresionesController = TextEditingController(text: "0");
  final TextEditingController _otrosController = TextEditingController(text: "0");
  // 3. Tiempos y ganancias comerciales
  final TextEditingController _horasController = TextEditingController(text: "0");
  final TextEditingController _pagoHoraController = TextEditingController(text: "20");
  final TextEditingController _indirectosController = TextEditingController(text: "30");
  final TextEditingController _gananciaController = TextEditingController(text: "30");

  // 4. Lista desplegable completa de anticipos (0% al 100%)
  String _anticipoSeleccionado = '50%';
  final Map<String, double> _porcentajesAnticipo = {
    '0%': 0.0, '10%': 0.10, '20%': 0.20, '30%': 0.30, '40%': 0.40,
    '50%': 0.50, '60%': 0.60, '70%': 0.70, '80%': 0.80, '90%': 0.90, '100%': 1.0,
  };

  // Variables de resultados y fechas
  String _fechaPedido = "No especificada";
  String _fechaEntrega = "No especificada";
  double _totalCalculado = 0.0;
  double _anticipoCalculado = 0.0;
  double _saldoPendiente = 0.0;
  bool _mostrarNota = false;
  Future<void> _seleccionarFecha(BuildContext context, bool esPedido) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );
    if (picked != null) {
      setState(() {
        String fechaFormateada = "${picked.day}/${picked.month}/${picked.year}";
        if (esPedido) _fechaPedido = fechaFormateada; else _fechaEntrega = fechaFormateada;
      });
    }
  }
  Future<void> _enviarWhatsApp() async {
    if (_totalCalculado == 0.0) return;
    String cliente = _clienteController.text.isEmpty ? "Público en General" : _clienteController.text;
    String modelo = _pinataController.text.isEmpty ? "Piñata Personalizada" : _pinataController.text;

    String numeroTelefono = "2321244601"; // Tu número oficial de respaldo automático
    String linkWhatsAppOculto = "https://wa.me";
    String linkFacebookOculto = _fbNegocioController.text;

    String mensaje = "✨ *NOTA DE ENTREGA - PIÑATAS DE SOFY* ✨\n"
                     "📍 *Dirección:* ${_dirController.text}\n\n"
                     "👤 *Cliente:* $cliente\n"
                     "📦 *Concepto:* $modelo\n"
                     "📅 *Fecha Pedido:* $_fechaPedido\n"
                     "📅 *Fecha Entrega:* $_fechaEntrega\n"
                     "-----------------------------------------\n"
                     "💬 *WhatsApp:* [$numeroTelefono]($linkWhatsAppOculto)\n"
                     "🌐 *Facebook:* [Las Piñatas De Sofy]($linkFacebookOculto)\n"
                     "-----------------------------------------\n"
                     "💰 *Total a Pagar:* \$${_totalCalculado.toStringAsFixed(2)} MXN\n"
                     "💵 *Anticipo cobrado:* \$${_anticipoCalculado.toStringAsFixed(2)} MXN ($_anticipoSeleccionado)\n"
                     "🚨 *Saldo Pendiente:* \$${_saldoPendiente.toStringAsFixed(2)} MXN\n"
                     "-----------------------------------------\n"
                     "_*gracias por comprar: tu apoyo significa muchísimo para mí gracias por confiar in mi trabajo y por permitirme ser parte de momentos tan especiales.*_";

    final Uri whatsappUrl = Uri.parse("https://wa.me?text=${Uri.encodeComponent(mensaje)}");
    
    if (await canLaunchUrl(whatsappUrl)) {
      await launchUrl(whatsappUrl, mode: LaunchMode.externalApplication);
    } else {
      final ScaffoldMessengerState scaffold = ScaffoldMessenger.of(context);
      scaffold.showSnackBar(const SnackBar(content: Text('Abriendo WhatsApp...')));
    }
  }
  void _calcularCotizacion() {
    double materialesTotal = 
        (double.tryParse(_cartonController.text) ?? 0.0) +
        (double.tryParse(_periodicoController.text) ?? 0.0) +
        (double.tryParse(_rafiaController.text) ?? 0.0) +
        (double.tryParse(_siliconController.text) ?? 0.0) +
        (double.tryParse(_harinaController.text) ?? 0.0) +
        (double.tryParse(_crepeController.text) ?? 0.0) +
        (double.tryParse(_cintaController.text) ?? 0.0) +
        (double.tryParse(_fomiController.text) ?? 0.0) +
        (double.tryParse(_impresionesController.text) ?? 0.0) +
        (double.tryParse(_otrosController.text) ?? 0.0);

    double horas = double.tryParse(_horasController.text) ?? 0.0;
    double precioHora = double.tryParse(_pagoHoraController.text) ?? 20.0;
    double manoObra = horas * precioHora;

    double indirectos = double.tryParse(_indirectosController.text) ?? 30.0;
    double margenGananciaPct = double.tryParse(_gananciaController.text) ?? 30.0;

    double subtotalCosto = materialesTotal + manoObra + indirectos;
    _totalCalculado = subtotalCosto * (1 + (margenGananciaPct / 100));
    double porcAnticipo = _porcentajesAnticipo[_anticipoSeleccionado] ?? 0.50;
    _anticipoCalculado = _totalCalculado * porcAnticipo;
    _saldoPendiente = _totalCalculado - _anticipoCalculado;

    setState(() { _mostrarNota = true; });
  }
  Widget _buildCardMaterial(String label, TextEditingController controller) {
    return Container(
      // REDUCIDO: Se baja el padding vertical de 14.0 a 6.0 para comprimir la cuadrícula
      padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 6.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xffcbd5e0), width: 1),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              label, 
              style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: Colors.black),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Container(
            width: 60,
            // REDUCIDO: Se baja la altura de la casilla de texto de 40 a 32
            height: 32,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: const Color(0xffcbd5e0)),
            ),
            child: TextField(
              controller: controller,
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 13),
              decoration: const InputDecoration(
                border: InputBorder.none, 
                isDense: true, 
                contentPadding: EdgeInsets.only(top: 4)
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInputVertical(String hint, TextEditingController controller, {bool esTexto = false}) {
    return Padding(
      // REDUCIDO: Se baja el espacio de separación vertical de 8.0 a 3.0
      padding: const EdgeInsets.symmetric(vertical: 3.0),
      child: TextField(
        controller: controller,
        keyboardType: esTexto ? TextInputType.text : TextInputType.number,
        style: const TextStyle(fontSize: 14),
        decoration: InputDecoration(
          labelText: hint,
          labelStyle: TextStyle(color: Colors.grey.shade600, fontSize: 13),
          alignLabelWithHint: true,
          // REDUCIDO: Padding interno más compacto
          contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
          border: const UnderlineInputBorder(),
        ),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Opacity(
            opacity: 0.06, 
            child: Center(
              child: SizedBox(
                width: 280,
                height: 280,
                child: CustomPaint(painter: PinataStarPainter()),
              ),
            ),
          ),
          SingleChildScrollView(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 20),

                // 🌟 LEYENDA PRINCIPAL CORRECTA AGREGADA ARRIBA DEL TODO
                const Text(
                  "PIÑATAS DE SOFY", 
                  textAlign: TextAlign.center, 
                  style: TextStyle(
                    fontSize: 26, 
                    fontWeight: FontWeight.bold, 
                    color: Color(0xffd53f8c),
                  ),
                ),
                const SizedBox(height: 15),

                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: const Color(0xff4a5568).withOpacity(0.2)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Datos del cliente y pedido", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 4),
                      _buildInputVertical("Nombre de la piñata", _pinataController, esTexto: true),
                      _buildInputVertical("Nombre del cliente", _clienteController, esTexto: true),
                      _buildInputVertical("Teléfono del Negocio", _telNegocioController),
                      _buildInputVertical("WhatsApp del Negocio", _waNegocioController),
                      _buildInputVertical("Enlace o Nombre de Facebook", _fbNegocioController, esTexto: true),
                      _buildInputVertical("Dirección", _dirController, esTexto: true),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("Fecha pedido:", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                          SizedBox(
                            height: 32,
                            child: OutlinedButton(
                              onPressed: () => _seleccionarFecha(context, true),
                              style: OutlinedButton.styleFrom(padding: const EdgeInsets.symmetric(horizontal: 10), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))),
                              child: Text(_fechaPedido, style: const TextStyle(color: Colors.black87, fontSize: 13)),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("Fecha de entrega:", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                          SizedBox(
                            height: 32,
                            child: OutlinedButton(
                              onPressed: () => _seleccionarFecha(context, false),
                              style: OutlinedButton.styleFrom(padding: const EdgeInsets.symmetric(horizontal: 10), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))),
                              child: Text(_fechaEntrega, style: const TextStyle(color: Colors.black87, fontSize: 13)),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: const Color(0xff4a5568).withOpacity(0.2)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Gastos directos (Materiales)", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 10),
                      GridView.count(
                        crossAxisCount: 2,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        // OPTIMIZADO: Proporción de aspecto reducida para que las tarjetas sean menos altas
                        childAspectRatio: 2.3,
                        mainAxisSpacing: 8,
                        crossAxisSpacing: 8,
                        children: [
                          _buildCardMaterial("Cartón \$:", _cartonController),
                          _buildCardMaterial("Periódico \$:", _periodicoController),
                          _buildCardMaterial("Rafia \$:", _rafiaController),
                          _buildCardMaterial("Silicón \$:", _siliconController),
                          _buildCardMaterial("Harina \$:", _harinaController),
                          _buildCardMaterial("Papel crepé \$:", _crepeController),
                          _buildCardMaterial("Cinta Canela \$:", _cintaController),
                          _buildCardMaterial("Fomi \$:", _fomiController),
                          _buildCardMaterial("Impresiones \$:", _impresionesController),
                          _buildCardMaterial("Otros \$:", _otrosController),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: const Color(0xff4a5568).withOpacity(0.2)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Tiempo y Ganancia", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 6),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("Horas de Trabajo:", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                          SizedBox(width: 100, height: 35, child: TextField(controller: _horasController, keyboardType: TextInputType.number, style: const TextStyle(fontSize: 13), decoration: InputDecoration(contentPadding: const EdgeInsets.symmetric(horizontal: 6), border: OutlineInputBorder(borderRadius: BorderRadius.circular(6))))),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("Precio por hora \$:", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                          SizedBox(width: 100, height: 35, child: TextField(controller: _pagoHoraController, keyboardType: TextInputType.number, style: const TextStyle(fontSize: 13), decoration: InputDecoration(contentPadding: const EdgeInsets.symmetric(horizontal: 6), border: OutlineInputBorder(borderRadius: BorderRadius.circular(6))))),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("Gastos indirectos \$:", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                          SizedBox(width: 100, height: 35, child: TextField(controller: _indirectosController, keyboardType: TextInputType.number, style: const TextStyle(fontSize: 13), decoration: InputDecoration(contentPadding: const EdgeInsets.symmetric(horizontal: 6), border: OutlineInputBorder(borderRadius: BorderRadius.circular(6))))),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("Margen de ganancia %:", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                          SizedBox(width: 100, height: 35, child: TextField(controller: _gananciaController, keyboardType: TextInputType.number, style: const TextStyle(fontSize: 13), decoration: InputDecoration(contentPadding: const EdgeInsets.symmetric(horizontal: 6), border: OutlineInputBorder(borderRadius: BorderRadius.circular(6))))),
                        ],
                      ),
                      const SizedBox(height: 10),
                      SizedBox(
                        height: 48,
                        child: InputDecorator(
                          decoration: const InputDecoration(labelText: 'Porcentaje de Anticipo', border: OutlineInputBorder(), contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 4)),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              value: _anticipoSeleccionado,
                              isExpanded: true,
                              style: const TextStyle(fontSize: 13, color: Colors.black),
                              onChanged: (String? nuevoValor) {
                                setState(() { _anticipoSeleccionado = nuevoValor!; });
                              },
                              items: _porcentajesAnticipo.keys.map<DropdownMenuItem<String>>((String valor) {
                                return DropdownMenuItem<String>(value: valor, child: Text("Anticipo de $valor"));
                              }).toList(),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 15),
                ElevatedButton(
                  onPressed: _calcularCotizacion,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xff2d3748),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  ),
                  child: const Text("CALCULAR Y CREAR NOTA", style: TextStyle(fontSize: 14, color: Colors.white, fontWeight: FontWeight.bold)),
                ),
                if (_mostrarNota) ...[
                  const SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: const Color(0xffd53f8c), width: 3),
                    ),
                    child: Stack(
                      children: [
                        // INTEGRADO: Tu logotipo oficial plasmado por detrás sin alterar tus botones
                        Positioned.fill(
                          child: Opacity(
                            opacity: 0.18, 
                            child: CustomPaint(painter: PinataStarPainter()),
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            const Text("NOTA DE ENTREGA", textAlign: TextAlign.center, style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xffd53f8c))),
                            const Text("PIÑATAS DE SOFY", textAlign: TextAlign.center, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xffd53f8c))),
                            const SizedBox(height: 6),
                            Text(_dirController.text, textAlign: TextAlign.center, style: const TextStyle(fontSize: 13, color: Colors.black87)),
                            const SizedBox(height: 12),
                            
                            // 📞 Renglón del Teléfono
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(Icons.phone, size: 16, color: Colors.blue),
                                const SizedBox(width: 5),
                                Text("Tel: ${_telNegocioController.text}", style: const TextStyle(fontSize: 13, color: Colors.blue, decoration: TextDecoration.underline)),
                              ],
                            ),
                            const SizedBox(height: 8),
                            
                            // 💬 Renglón de WhatsApp (Al darle clic abre tu chat)
                            InkWell(
                              onTap: _enviarWhatsApp,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(Icons.chat, size: 16, color: Colors.blue),
                                  const SizedBox(width: 5),
                                  Text("WhatsApp: ${_waNegocioController.text}", style: const TextStyle(fontSize: 13, color: Colors.blue, decoration: TextDecoration.underline)),
                                ],
                              ),
                            ),
                            const SizedBox(height: 8),
                            
                            // 🌐 TU SOLUCIÓN EXACTA: Apertura forzada al navegador web con tu link para ir directo al muro de Las Piñatas de Sofy
                            InkWell(
                              onTap: () async {
                                final Uri urlDirectaMuro = Uri.parse("https://www.facebook.com/profile.php?id=100090027413873");
                                
                                // Se fuerza a Android a abrir el link de internet directamente en Chrome o el navegador web
                                if (await canLaunchUrl(urlDirectaMuro)) {
                                  await launchUrl(
                                    urlDirectaMuro, 
                                    mode: LaunchMode.externalApplication,
                                  );
                                }
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(Icons.facebook, size: 16, color: Colors.blue),
                                  const SizedBox(width: 5),
                                  const Text("Facebook: Las Piñatas De Sofy", style: TextStyle(fontSize: 13, color: Colors.blue, decoration: TextDecoration.underline)),
                                ],
                              ),
                            ),
                            
                            const Divider(thickness: 1.5),
                            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [const Text("Cliente:", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)), Text(_clienteController.text.isEmpty ? "Público en General" : _clienteController.text, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15))]),
                            const SizedBox(height: 6),
                            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [const Text("Concepto:", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)), Text(_pinataController.text.isEmpty ? "Piñata Personalizada" : _pinataController.text, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15))]),
                            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [const Text("Fecha Pedido:"), Text(_fechaPedido)]),
                            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [const Text("Fecha Entrega:"), Text(_fechaEntrega)]),
                            const Divider(thickness: 1.5),
                            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [const Text("Total a Pagar:", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)), Text("\$${_totalCalculado.toStringAsFixed(2)}", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16))]),
                            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [const Text("Anticipo cobrado:"), Text("\$${_anticipoCalculado.toStringAsFixed(2)} ($_anticipoSeleccionado)")]),
                            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [const Text("Saldo Pendiente:", style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xffd53f8c))), Text("\$${_saldoPendiente.toStringAsFixed(2)}", style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xffd53f8c)))]),
                            const Divider(),
                            const Text("gracias por comprar: tu apoyo significa muchísimo para mí gracias por confiar in mi trabajo y por permitirme ser parte de momentos tan especiales.", textAlign: TextAlign.center, style: TextStyle(fontSize: 13, fontStyle: FontStyle.italic)),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 15),
                  ElevatedButton.icon(
                    onPressed: _enviarWhatsApp,
                    style: ElevatedButton.styleFrom(backgroundColor: const Color(0xff48bb78), padding: const EdgeInsets.symmetric(vertical: 14), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25))),
                    icon: const Icon(Icons.share, color: Colors.white),
                    label: const Text("ENVIAR NOTA POR WHATSAPP", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Divider extends StatelessWidget {
  final Color color; final double thickness;
  const Divider({super.key, this.color = Colors.grey, this.thickness = 1});
  @override
  Widget build(BuildContext context) {
    return Container(margin: const EdgeInsets.symmetric(vertical: 8), height: thickness, color: color);
  }
}

class PinataStarPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final double cx = size.width / 2; final double cy = size.height / 2 - 20;
    final Offset center = Offset(cx, cy);
    final Paint pRosa = Paint()..color = const Color(0xffe91e63)..style = PaintingStyle.fill;
    final Paint pAmarillo = Paint()..color = const Color(0xffffca28)..style = PaintingStyle.fill;
    final Paint pNaranja = Paint()..color = const Color(0xffff7043)..style = PaintingStyle.fill;
    final Paint pNegroDetalle = Paint()..color = const Color(0xff212121)..style = PaintingStyle.stroke..strokeWidth = 2.0;
    final Paint pNegroRelleno = Paint()..color = const Color(0xff212121)..style = PaintingStyle.fill;
    final Paint pSerpMora = Paint()..color = const Color(0xff7e57c2)..style = PaintingStyle.stroke..strokeWidth = 3.0;
    final Paint pSerpRosa = Paint()..color = const Color(0xfff06292)..style = PaintingStyle.stroke..strokeWidth = 2.5;

    Path serp1 = Path()..moveTo(cx - 100, cy)..cubicTo(cx - 80, cy - 40, cx - 60, cy + 40, cx - 40, cy - 20);
    canvas.drawPath(serp1, pSerpMora);
    Path serp2 = Path()..moveTo(cx + 40, cy - 30)..cubicTo(cx + 60, cy + 30, cx + 80, cy - 50, cx + 110, cy - 10);
    canvas.drawPath(serp2, pSerpRosa);

    canvas.drawCircle(Offset(cx - 70, cy - 60), 3, Paint()..color = const Color(0xff00e676));
    canvas.drawCircle(Offset(cx + 80, cy + 50), 3.5, Paint()..color = const Color(0xffffeb3b));
    canvas.drawCircle(Offset(cx - 40, cy + 80), 2.5, Paint()..color = const Color(0xff29b6f6));

    canvas.drawCircle(center, 40, pRosa); canvas.drawCircle(center, 40, pNegroDetalle);
    canvas.drawCircle(center, 28, pNaranja); canvas.drawCircle(center, 16, pAmarillo); canvas.drawCircle(center, 16, pNegroDetalle);

    final List<Offset> pB = [
      Offset(cx, cy - 35), Offset(cx + 30, cy - 20), Offset(cx + 35, cy), Offset(cx + 25, cy + 25),
      Offset(cx, cy + 35), Offset(cx - 25, cy + 25), Offset(cx - 35, cy), Offset(cx - 30, cy - 20)
    ];
    final List<Offset> pP = [
      Offset(cx, cy - 85), Offset(cx + 65, cy - 65), Offset(cx + 85, cy), Offset(cx + 60, cy + 60),
      Offset(cx, cy + 85), Offset(cx - 60, cy + 60), Offset(cx - 85, cy), Offset(cx - 65, cy - 65)
    ];

    for (int i = 0; i < 8; i++) {
      Path picoPath = Path()..moveTo(pB[i].dx, pB[i].dy)..lineTo(pP[i].dx, pP[i].dy)..lineTo(pB[(i + 1) % 8].dx, pB[(i + 1) % 8].dy);
      canvas.drawPath(picoPath, i % 2 == 0 ? pRosa : pAmarillo); canvas.drawPath(picoPath, pNegroDetalle);
      canvas.drawCircle(pP[i], 5, pNegroRelleno);
      canvas.drawLine(pP[i], Offset(pP[i].dx + 6, pP[i].dy + 12), pNegroDetalle);
      canvas.drawLine(pP[i], Offset(pP[i].dx - 6, pP[i].dy + 12), pNegroDetalle);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
