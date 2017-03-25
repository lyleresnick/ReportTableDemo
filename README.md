# ReportTableDemo

This iOS app demonstrates an architectual solution to a fairly complex banking report scene.

It shows an architecture for breaking up a potentially very Massive View Controller by using the following classes:
- a ViewModel
- a Data Transformer which transforms its input View Model to an output protocol
  -- there are two transformers: one processes data originating from two separate streams, the other processes data originating from a single stream  
- an Adapter acting as, both, a data source for a TableView and as a data sink for the Data Transformer

Note that the view models used here are not the ViewModels implied by the MVVM pattern
