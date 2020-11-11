module Tile exposing (..)
import Html.Styled exposing (Html, br, div, text)
import Common exposing (Tile, Msg(..))
import Html.Styled.Attributes exposing (class)
import Html.Styled.Events exposing (onClick)
import Style exposing (tileCss)
import Style exposing (checkedTileCss)



makeTile: Int -> Tile
makeTile idx =
    { index = idx
    , text = ""
    , checked = False
    }

view: Tile -> Html Msg
view tile = div 
    (case tile.checked of
        True -> 
            [ tileCss, checkedTileCss
            , onClick (CheckTile tile.index)
            ]
        False ->
            [ tileCss 
            , onClick (CheckTile tile.index)
            ]
    )
    (case tile.index of
        25 ->
            [ text tile.text, br [] [], text "(fri ruta)"]
        default ->    
            [ text tile.text ]
    )