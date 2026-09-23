## Sales Tax Receipt Calculator
Ruby application that calculates sales taxes and prints the receipt for a shopping basket.

### Prerequisites

Ruby version 4.0.6

### Running the project
Install the dependencies:

```
bundle install
```

Run the Ruby program:
```
ruby receipt.rb
```

Run tests:
```
bundle exec rspec
```

The application reads the input file from `tmp/input.txt` as plain text with this format:

`<quantity> [imported] <product name> at <price>`

example:
```
1 imported bottle of perfume at 27.99
1 bottle of perfume at 18.99
1 packet of headache pills at 9.75
3 imported boxes of chocolates at 11.25
```

### Assumptions

* The solution uses a list of keywords (book, chocolate, pills, headache, etc.) found in the name to decide whether an item is exempt from the 10% basic tax. Is a simple heuristic and doesn't cover every possible product but it's the simpler solution for the few categories mentioned in the examples.

* Rounding is applied per individual tax (basic tax and the import duty). Rounding the sum of both could produce a different result.

* Money is handled carefully because of floating-point precision. Adding and multiplying Float values in Ruby can produce small imprecisions (e.g. 14.99 + 1.5 == 16.490000000000002 instead of 16.49), due to how decimal numbers are represented in binary. To avoid this, TaxCalculator rounds the tax result to 2 decimal places right after the "round up to the nearest nickel" step.

* BasketItem represents only the data of a basket entry (name, price, quantity, whether it's imported). All tax calculation logic lives in TaxCalculator. Mixing the two into a single class would make the model "aware" of tax rules, making it harder to test and evolve each part independently. If the tax rules has to change (a new rate, a new exemption), the change stays isolated in TaxCalculator, without touching BasketItem, Basket, or the parser.

* BasketItem uses TaxCalculator exposing simple methods (total_price, total_tax, etc.) to whoever uses the class.

* Rates (BASIC_RATE, IMPORT_RATE), the rounding unit (NICKEL), and the exemption keywords (EXEMPT_KEYWORDS) are constants inside TaxCalculator, not loose in the file's global scope.

* Parsing errors raise a clear message, instead of letting Ruby raise a generic error. The entry point (receipt.rb) catches expected failures (missing file, parsing error) and shows a friendly message to the user.
