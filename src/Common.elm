module Common exposing (..)
import Http
import Json.Decode exposing (Decoder, map2, map3, field, string, list, int, bool)
type Msg
    = GotContent (Result Http.Error Model)
    | CheckTile Int

type alias Model = 
    { board: (List Tile)
    , header: String
    }

type alias Tile = 
    { text: String
    , index: Int
    , checked: Bool
    }

contentDecoder: Decoder Model
contentDecoder =
    map2 Model
        (field "board" (list tileDecoder))
        (field "header" string)


tileDecoder: Decoder Tile
tileDecoder =
    map3 Tile
        (field "text" string)
        (field "index" int)
        (field "checked" bool)
