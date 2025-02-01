/*
 Common Annotations shared by all apps
*/

using { quizapp as my } from '../../quizapp';

////////////////////////////////////////////////////////////////////////////
//
//	Books Lists
//
annotate my.Books with @(
  Common.SemanticKey : [ID],
  UI                 : {
    Identification  : [{ Value: title }],
    SelectionFields : [
      ID,
      author_ID,
      price,
      currency_code
    ],
    LineItem        : [
      { Value: ID, Label: '{i18n>Title}' },
      { Value: author.ID, Label: '{i18n>Author}' },
      { Value: stock },
      { Value: price },
      { Value: currency.symbol },
    ]
  }
) {
  ID  @Common: {
    SemanticObject : 'Books',
    Text: title,
    TextArrangement : #TextOnly
  };
  author @ValueList.entity      : 'Authors';
};

////////////////////////////////////////////////////////////////////////////
//
//	Books Details
//
annotate my.Books with @(UI : {HeaderInfo : {
  TypeName       : '{i18n>Book}',
  TypeNamePlural : '{i18n>Books}',
  Title          : { Value: title },
  Description    : { Value: author.name }
}, });


////////////////////////////////////////////////////////////////////////////
//
//	Books Elements
//
annotate my.Books with {
  ID     @title: '{i18n>ID}';
  title  @title: '{i18n>Title}';
  author @title: '{i18n>Author}'  @Common: { Text: author.name, TextArrangement: #TextOnly };
  price  @title: '{i18n>Price}'   @Measures.ISOCurrency : currency_code;
  stock  @title: '{i18n>Stock}';
  descr  @title: '{i18n>Description}'  @UI.MultiLineText;
  image  @title: '{i18n>Image}';
}


////////////////////////////////////////////////////////////////////////////
//
//	Authors List
//
annotate my.Authors with @(
  Common.SemanticKey : [ID],
  UI                 : {
    Identification  : [{ Value: name}],
    SelectionFields : [name],
    LineItem        : [
      { Value: ID },
      { Value: dateOfBirth },
      { Value: dateOfDeath },
      { Value: placeOfBirth },
      { Value: placeOfDeath },
    ],
  }
) {
  ID  @Common: {
    SemanticObject : 'Authors',
    Text: name,
    TextArrangement : #TextOnly,
  };
};

////////////////////////////////////////////////////////////////////////////
//
//	Author Details
//
annotate my.Authors with @(UI : {
  HeaderInfo : {
    TypeName       : '{i18n>Author}',
    TypeNamePlural : '{i18n>Authors}',
    Title          : { Value: name },
    Description    : { Value: dateOfBirth }
  },
  Facets     : [{
    $Type  : 'UI.ReferenceFacet',
    Target : 'books/@UI.LineItem'
  }, ],
});


////////////////////////////////////////////////////////////////////////////
//
//	Authors Elements
//
annotate my.Authors with {
  ID           @title: '{i18n>ID}';
  name         @title: '{i18n>Name}';
  dateOfBirth  @title: '{i18n>DateOfBirth}';
  dateOfDeath  @title: '{i18n>DateOfDeath}';
  placeOfBirth @title: '{i18n>PlaceOfBirth}';
  placeOfDeath @title: '{i18n>PlaceOfDeath}';
}
