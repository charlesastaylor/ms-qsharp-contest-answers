namespace Solution {
    open Microsoft.Quantum.Primitive;
    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Extensions.Convert;

    operation Test () : Unit {
        body (...) {
            PrintPalindromes(2);
        }
        // adjoint auto;
    }

    function PrintPalindromes (length : Int) : Unit {
        let x = Palindromes(length);
        Message("Length: " + ToStringI(length));
        Message("#Palindromes: " + ToStringI(Length(x)));
        for (p in x) {
            Message(ToStringI(PositiveIntFromBoolArr(p)));
        }
    }
}