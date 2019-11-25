module Scale exposing (..)


type alias Scale =
    { accidental : Accidental
    , note : Note
    , tonality : Tonality
    }


toString : Scale -> String
toString s =
    noteToString s.note
        ++ accidentalToString s.accidental
        ++ " "
        ++ tonalityToString s.tonality


type Accidental
    = None
    | Sharp
    | Flat


accidentalToString : Accidental -> String
accidentalToString a =
    case a of
        None ->
            ""

        Sharp ->
            "♯"

        Flat ->
            "♭"


type Note
    = A
    | B
    | C
    | D
    | E
    | F
    | G


noteToString : Note -> String
noteToString n =
    case n of
        A ->
            "A"

        B ->
            "B"

        C ->
            "C"

        D ->
            "D"

        E ->
            "E"

        F ->
            "F"

        G ->
            "G"


type Tonality
    = Major
    | Minor Minor


tonalityToString : Tonality -> String
tonalityToString t =
    case t of
        Major ->
            "Major"

        Minor m ->
            minorToString m ++ " Minor"


type Minor
    = Harmonic
    | Natural
    | Melodic


minorToString : Minor -> String
minorToString m =
    case m of
        Harmonic ->
            "Harmonic"

        Natural ->
            "Natural"

        Melodic ->
            "Melodic"
