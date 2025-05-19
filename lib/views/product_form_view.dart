import 'dart:math';

import 'package:flutter/material.dart';
import 'package:minha_loja/models/product.dart';

class ProductFormView extends StatefulWidget {
  const ProductFormView({super.key});

  @override
  State<ProductFormView> createState() => _ProductFormViewState();
}

class _ProductFormViewState extends State<ProductFormView> {
  final _priceFocus = FocusNode();
  final _descriptionFocus = FocusNode();

  final _imageUrlFocus = FocusNode();
  final _imageUrlController = TextEditingController();

  final _globalKey = GlobalKey<FormState>();

  final _formData = Map<String, Object>();

  @override
  void initState() {
    super.initState();
    _imageUrlFocus.addListener(updateImage);
  }

  @override
  void dispose() {
    super.dispose();
    _priceFocus.dispose();
    _descriptionFocus.dispose();

    _imageUrlFocus.removeListener(updateImage);
    _imageUrlFocus.dispose();
  }

  void updateImage() {
    setState(() {});
  }

  bool isValidImageUrl(String url) {
    bool isValidUrl = Uri.tryParse(url)?.hasAbsolutePath ?? false;
    bool endsWithFile =
        url.toLowerCase().endsWith('.png') ||
        url.toLowerCase().endsWith('.jpg') ||
        url.toLowerCase().endsWith('.jpeg');
    return isValidUrl && endsWithFile;
  }

  void _submitForm() {
    final isValid = _globalKey.currentState?.validate() ?? false;
    if (!isValid) {
      return;
    }

    _globalKey.currentState?.save();
    final newProduct = Product(
      id: Random().nextDouble().toString(),
      name: _formData['name'] as String,
      price: _formData['price'] as double,
      description: _formData['description'] as String,
      imageUrl: _formData['imageUrl'] as String,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Formulário de Produto'),
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white,
        actions: [
          IconButton(onPressed: _submitForm, icon: const Icon(Icons.save)),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Form(
          key: _globalKey,
          child: ListView(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Nome'),
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_priceFocus);
                },
                onSaved: (name) => _formData['name'] = name ?? '',
                validator: (_name) {
                  final nameValue = _name ?? '';
                  if (nameValue.trim().isEmpty) {
                    return 'O nome é obrigatório';
                  }
                  if (nameValue.trim().length < 3) {
                    return 'O nome deve ter pelo menos 3 letras';
                  }
                  return null;
                },
              ),

              TextFormField(
                decoration: InputDecoration(labelText: 'Preço'),
                textInputAction: TextInputAction.next,
                focusNode: _priceFocus,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_descriptionFocus);
                },
                onSaved: (price) => _formData['price'] = double.parse(price!),
                validator: (_price) {
                  final priceValue = _price ?? '';
                  final priceNumber = double.tryParse(priceValue) ?? -1;

                  if (priceNumber <= 0) {
                    return 'Informe um preço maior que zero';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Descrição'),
                textInputAction: TextInputAction.next,
                focusNode: _descriptionFocus,
                keyboardType: TextInputType.multiline,
                maxLines: 3,
                onSaved:
                    (description) =>
                        _formData['description'] = description ?? '',
                validator: (_description) {
                  final descriptionValue = _description ?? '';
                  if (descriptionValue.trim().isEmpty) {
                    return 'A descrição é obrigatória';
                  }
                  if (descriptionValue.trim().length < 10) {
                    return 'A descrição deve ter pelo menos 10 letras';
                  }
                  return null;
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: TextFormField(
                      decoration: InputDecoration(labelText: 'URL da Imagem'),
                      textInputAction: TextInputAction.done,
                      focusNode: _imageUrlFocus,
                      keyboardType: TextInputType.url,
                      controller: _imageUrlController,
                      onFieldSubmitted: (_) => _submitForm(),
                      onSaved:
                          (imageUrl) => _formData['imageUrl'] = imageUrl ?? '',
                      validator: (_imageUrl) {
                        final imageUrlValue = _imageUrl ?? '';
                        if (!isValidImageUrl(imageUrlValue)) {
                          return 'Informe uma URL válida';
                        }

                        return null;
                      },
                    ),
                  ),
                  Container(
                    width: 100,
                    height: 100,
                    margin: const EdgeInsets.only(top: 10, left: 10),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey, width: 1),
                    ),
                    alignment: Alignment.center,
                    child:
                        _imageUrlController.text.isEmpty
                            ? Text('Preview')
                            : FittedBox(
                              child: Image.network(
                                _imageUrlController.text,
                                fit: BoxFit.cover,
                              ),
                            ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
