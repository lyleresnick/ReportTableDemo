# ReportTableDemo

This iOS app demonstrates an architectual solution to a fairly complex banking report scene.

This is a refactoring of the [ReportTableAdapterDemo](https://github.com/lyleresnick/ReportTableAdapterDemo) to further distribute responsibilities into new or existing classes.

It shows an architecture for breaking up a potentially very Massive View Controller by using the following classes:
- a set of View Models

- a Transaction Model

- a Data Transformer which transforms its input View Model to an output protocol
  -- there are two transformers: one processes data originating from two separate streams, the other processes data originating from a single stream  
- an Adapter acting as, both, a data source for a TableView and as a data sink for the Data Transformer

The demonstration also uses Swift features, such as enums and iterators to improve the code's readability and robustness.

Note that the view models used here are not the ViewModels implied by the MVVM pattern

