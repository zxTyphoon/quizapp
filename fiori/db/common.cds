namespace sap.capire.bookshop;

using { sap.capire.bookshop } from '@capire/bookshop';

entity GenreHierarchy : bookshop.Genres {
  hierarchyLevel : Integer default 0;
  drillState     : String default 'leaf';
  parent         : Association to GenreHierarchy;
  children       : Composition of many GenreHierarchy on children.parent = $self;
}

extend service CatalogService with {
  @readonly entity GenreHierarchy as projection on bookshop.GenreHierarchy;
}