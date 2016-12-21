# Periodic Collection View of the Elements

## Objective

To build the classic graphical representation of the Periodic Table of the Elements
using a Collection View. The data will come from our familiar elements endpoint and
it will be stored in Core Data. We'll build the cell in a separate nib file.

## Mockup

![PToE](http://www.visionlearning.com/images/figure-images/52-a.jpg)

We'll probably only get as far as doing it in black and white and placing elements 57 and 89
within the main table and ignoring the rest of the Lanthanides and Actinides depicted in the broken 
out rows at bottom. The data model makes this
relatively easy. 

## Theme Song

[Tom Lehrer's Elements](https://www.youtube.com/watch?v=zGM-wSKFBpo)

[Also cute](https://www.youtube.com/watch?v=v1TfPDlA1xE), discovered in the related videos. 

## A note about cannibalization

![HtC](http://media.winnipegfreepress.com/images/4592857.jpg)

We will be grabbing code from (a.k.a. cannibalizing) the CoreArticles and MidtermElements
projects to build this one. There's a balance between blindly cutting and pasting and 
blindly retyping the same code. I think it's fair to say most developers have a sort of
database in their mind of projects they've worked on and the patterns that may be reusable
from them, but still not worth putting in a common location.

## Steps

1. Fork and clone.
1. Create a project named PeriodicTable inside.
1. Alter the storyboard to be a Collection View embeded in a Navigation Controller.
1. Create a UICollectionViewCell subclass with associated XIB file. Leave it empty for now.
1. Register the class in your collection view.
    ```swift
    // Register cell classes
    self.collectionView!.register(UINib(nibName:"ElementCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: reuseIdentifier)
    ```
1. Create a custom view named ElementView.swift. 
1. Create a nib file named ElementView.xib.
1. Add your custom view to your collection view cell. Yes, this is a nib backed view referencing another
    nib backed view.
1. Add a label for the element's symbol and a label for the element's number to the view and hook it up.
1. Test your collection view with some bogus data before moving on.

```swift
    let data = [("H", 1), ("He", 2), ("Li", 3)]
```

1. New File > Data Model. Accept the default name.

1. symbol, name, number, group, weight
not optional
index number and constrain on it. (index!)

6. Data Controller.swift

7. Element+JSON.swift
http://stackoverflow.com/questions/26319660/whats-the-best-practice-for-naming-swift-files-that-add-extensions-to-existing

8. Steal getData from Elements

9. Add data controller to AppDelegate (CoreArticles)

10. Initialize fetched results controller (cannibalize CoreArticles)

11. First try one section.

12. Then group and number sort.

13. Hmm, how are we going to balance this table?


http://stackoverflow.com/questions/22688851/make-font-grow-together-with-uilabel-resized-by-auto-layout-how-to-do-it-in


adjustsFontSizeToFitWidth property of UILabel will not grow up the font size, it is only for reducing according to the documentation: Normally, the label text is drawn with the font you specify in the font property. If this property is set to YES, however, and the text in the text property exceeds the label’s bounding rectangle, the receiver starts reducing the font size until the string fits or the minimum font size is reached.

But if you set font size big enough (say 200) and set adjustsFontSizeToFitWidth to YES, i think you would get interestingly valuable results.

**Important** And do not forget to set ```Baseline``` as ```Align Centers```, otherwise your text may not be seen properly.

Please inform us about your results.
