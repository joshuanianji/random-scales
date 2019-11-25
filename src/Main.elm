module Main exposing (..)

import Browser
import Element exposing (..)
import Element.Border as Border
import Element.Font as Font
import Element.Input as Input
import Html exposing (Html)
import Random exposing (Generator)
import Scale exposing (Accidental(..), Minor(..), Note(..), Scale, Tonality(..))


main : Program () Model Msg
main =
    Browser.element
        { init = init
        , view = view
        , update = update
        , subscriptions = always Sub.none
        }



-- MODEL AND SUPPORTING TYPES


type alias Model =
    { scale : Maybe Scale
    }


init : () -> ( Model, Cmd Msg )
init _ =
    ( Model Nothing, Cmd.none )



-- VIEW


view : Model -> Html Msg
view model =
    let
        ( words, scale ) =
            case model.scale of
                Nothing ->
                    ( "You haven't chosen a scale yet!", Nothing )

                Just s ->
                    ( "You got:", Just (Scale.toString s) )
    in
    column
        [ width fill
        , spacing 64
        , centerY
        ]
        [ column
            [ centerX
            , spacing 32
            ]
            [ el
                [ Font.size 24
                , Font.center
                , width fill
                ]
              <|
                text words
            , case scale of
                Nothing ->
                    el [ height (px 32) ] Element.none

                Just s ->
                    el
                        [ Font.size 32
                        , Font.bold
                        , Font.center
                        , width fill
                        ]
                    <|
                        text s
            ]
        , Input.button
            [ padding 32
            , Border.rounded 8
            , centerX
            , Border.width 4
            , Border.color <| rgb 0 0 0
            ]
            { onPress = Just RandomScale
            , label = text "Generate a random scale!"
            }
        ]
        |> layout
            [ Font.family
                [ Font.typeface "Lato" ]
            , height fill
            ]



-- MSG


type Msg
    = RandomScale
    | GeneratedScale Scale



-- UPDATE


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        -- user wants a scale
        RandomScale ->
            ( model, newScale )

        -- we return the new scale
        GeneratedScale scale ->
            ( { model | scale = Just scale |> Debug.log "scale" }, Cmd.none )


newScale : Cmd Msg
newScale =
    Random.generate GeneratedScale scaleGenerator



-- generates a random scale


scaleGenerator : Generator Scale
scaleGenerator =
    Random.map3 Scale
        (Random.uniform None [ Sharp, Flat ])
        (Random.uniform A [ B, C, D, E, F, G ])
        -- I have to put Minor Harmonic just for the types to work out. I disregard the Harmonic later on
        (Random.uniform Major [ Minor Harmonic ]
            |> Random.andThen
                (\tonality ->
                    case tonality of
                        Major ->
                            Random.constant Major

                        Minor _ ->
                            Random.uniform Harmonic [ Natural, Melodic ]
                                |> Random.map Minor
                )
        )
