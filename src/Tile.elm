module Tile exposing (..)
import Html.Styled exposing (Html, br, div, text, button)
import Common exposing (Tile, Msg(..))
import Html.Styled.Attributes exposing (class)
import Html.Styled.Events exposing (onMouseDown)
import Style exposing (bingoTileCss, checkedTileCss, tileCss, uncheckedTileCss)

makeTile: Int -> Tile
makeTile idx =
    { index = idx
    , text = ""
    , checked = False
    }

view: (Tile -> Bool) -> Tile -> Html Msg
view bingo tile =
    let baseAttrs = [ tileCss, onMouseDown (CheckTile tile.index)] in
    div 
    (case tile.checked of
        True -> 
            if bingo tile then 
                bingoTileCss :: baseAttrs
            else
                checkedTileCss :: baseAttrs
        False ->
            uncheckedTileCss :: baseAttrs
    )
    (case tile.index of
        12 ->
            [ text tile.text, br [] [], text "(fri ruta)"]
        default ->    
            [ text tile.text ]
    )