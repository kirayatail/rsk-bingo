module Header exposing (..)

import Common exposing (Msg(..))
import Html.Styled exposing (..)
import Html.Styled.Attributes exposing (class)
import Style exposing (headerCss)
import Style exposing (headerTileCss)

headerTile: String -> Html Msg
headerTile char =
    div [headerTileCss] [text char]

view: String -> Html Msg
view header =
    div [headerCss] <| List.map headerTile (String.split "" header)
