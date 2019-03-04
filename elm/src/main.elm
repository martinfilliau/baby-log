import Browser
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onInput, onClick)
import Html.Keyed as Keyed
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

type alias Entries = List Entry

init : Entries
init =
  [Entry "" ""]

-- UPDATE

type Msg
  = Add Entry

update : Msg -> Entries -> Entries
update msg entries =
  case msg of
    Add newEntry ->
      newEntry :: entries

-- VIEW

view : Entries -> Html Msg
view entries =
--  div []
--    [ input [ type_ "text", placeholder "Type", value entry.key ]
--    , input [ type_ "text", placeholder "Valeur", value entry.value]  
--    , button [ onClick Add ] [ text "+" ]
--    ]
  div []
    [ viewEntries entries ]

viewEntries : Entries -> Html Msg
viewEntries entries =
    section
        [ Keyed.ul <|
            List.map viewKeyedEntry (entries)
        ]

viewKeyedEntry : Entry -> ( String, Html Msg )
viewKeyedEntry entry =
    ( viewEntry entry )


viewEntry : Entry -> Html Msg
viewEntry entry =
    [ text entry.key ]
    
