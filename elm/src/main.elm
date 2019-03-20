module Main exposing (Entries, Entry, Model, Msg(..), init, main, newEntry, update, view, viewEntries, viewEntry, viewKeyedEntry, viewNewEntry)

import Browser
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick, onInput)
import Html.Keyed as Keyed
import Tachyons exposing (classes, tachyons)
import Tachyons.Classes exposing (center, f6, mw8, pa3, stripe_dark, w_100)



-- import Date exposing (..)
-- MAIN


main =
    Browser.sandbox { init = init, update = update, view = view }



-- MODELS


type alias Entry =
    { key : String
    , value : String

    --  , date : Date
    }


type alias Entries =
    List Entry


type alias Model =
    { entries : Entries
    , newEntry : Entry
    }


init : Model
init =
    { entries = [ Entry "de" "mo" ]
    , newEntry = { key = "", value = "" }
    }


newEntry : Entry
newEntry =
    { key = ""
    , value = ""
    }



-- UPDATE


type Msg
    = Add
    | UpdateNewKey String
    | UpdateNewValue String


update : Msg -> Model -> Model
update msg model =
    case msg of
        Add ->
            { entries = model.entries ++ [ model.newEntry ]
            , newEntry = { key = "", value = "" }
            }

        UpdateNewKey str ->
            { newEntry =
                { key = str
                , value = model.newEntry.value
                }
            , entries = model.entries
            }

        UpdateNewValue str ->
            { newEntry =
                { key = model.newEntry.key
                , value = str
                }
            , entries = model.entries
            }



-- VIEW


view : Model -> Html Msg
view model =
    div []
        [ tachyons.css -- XXX TODO use CDN in prod
        , div []
            [ viewNewEntry model.newEntry
            , viewEntries model.entries
            ]
        ]


viewNewEntry : Entry -> Html Msg
viewNewEntry entry =
    div []
        [ input [ type_ "text", placeholder "Type", value entry.key, onInput UpdateNewKey ] []
        , input [ type_ "text", placeholder "Valeur", value entry.value, onInput UpdateNewValue ] []
        , button [ onClick Add ] [ text "+" ]
        ]


viewEntries : Entries -> Html Msg
viewEntries entries =
    table [ classes [ f6, w_100, mw8, center ] ]
        [ Keyed.node "tr" [ classes [ stripe_dark ] ] (List.map viewKeyedEntry entries)
        ]


viewKeyedEntry : Entry -> ( String, Html Msg )
viewKeyedEntry entry =
    ( entry.key, viewEntry entry )


viewEntry : Entry -> Html Msg
viewEntry entry =
    section []
        [ td [ classes [ pa3 ] ] [ text entry.key ]
        , td [ classes [ pa3 ] ] [ text entry.value ]
        ]
