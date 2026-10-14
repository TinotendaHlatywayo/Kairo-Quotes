const defaultTerms = <String>[
  'In case of loose formation, we need to install double casing and will charge per meter ......... /meter',
  'E.M gives you a warranty on structural defects of the borehole for 1 year',
  'Final price depends on work done. Any other services will be charged extra',
  'This is not a wet hole contract. Water guarantee is not given in this contract',
  '100% of the payment made in advance',
  'Accessibility of drilling rig to the site has to be assured by the client',
  'Validity of the estimate: 30 days',
];

class CatalogSeedItem {
  const CatalogSeedItem(this.name, {this.unit = ''});

  final String name;
  final String unit;
}

class CatalogSeedSection {
  const CatalogSeedSection(this.name, this.items);

  final String name;
  final List<CatalogSeedItem> items;
}

const starterCatalog = <CatalogSeedSection>[
  CatalogSeedSection('ZINWA & SURVEY', [
    CatalogSeedItem('Geophysical Survey'),
    CatalogSeedItem('ZINWA Levy'),
  ]),
  CatalogSeedSection('6 1/2" DRILLING UP TO 40 MTS', [
    CatalogSeedItem('Mobilisation and Demobilisation'),
    CatalogSeedItem('Establishment of Machinery & Personnel'),
    CatalogSeedItem('Water well drilling up to 40 mtrs', unit: 'metre'),
    CatalogSeedItem('Supply and installation of plain/perforated casing pipes', unit: 'metre'),
    CatalogSeedItem('Gravel packing up to necessary depth', unit: 'metre'),
    CatalogSeedItem('Extra drilling from 40 mts', unit: 'metre'),
    CatalogSeedItem('Double casing', unit: 'metre'),
  ]),
  CatalogSeedSection('INSTALLATION', [
    CatalogSeedItem('Electrical/Solar'),
    CatalogSeedItem('Tank/Tank Stand'),
  ]),
];
