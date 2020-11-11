module Style exposing (..)
import Css exposing (..)
import Html.Styled.Attributes exposing (css)
import Html.Styled exposing (Attribute)

mainCss: Attribute msg
mainCss =
    css 
    [ fontFamily sansSerif
    ]

headerCss: Attribute msg
headerCss = 
    css 
    [ displayFlex
    , justifyContent spaceAround
    , border3 (px 1) solid (rgb 0 0 0)
    , boxSizing borderBox
    , width (vw 90)
    , height (vw 15)
    , marginLeft (vw 5)
    , marginRight (vw 5)
    , marginTop (vw 5)
    , textTransform uppercase
    ]

headerTileCss: Attribute msg
headerTileCss = 
    css 
    [ width (pct 20)
    , fontSize (vw 10)
    , displayFlex
    , justifyContent center
    , alignItems center
    ]

boardCss: Attribute msg
boardCss = 
    css 
    [ width (vw 90)
    , marginLeft (vw 5)
    , marginRight (vw 5)
    , displayFlex
    , flexWrap wrap
    ]

tileCss: Attribute msg 
tileCss = 
    css
    [ width (vw 18)
    , height (vw 18)
    , boxSizing borderBox
    , border3 (px 1) solid (rgb 0 0 0)
    , displayFlex
    , justifyContent center
    , alignItems center
    , fontSize (vw 2.5)
    , textAlign center
    ]

checkedTileCss: Attribute msg
checkedTileCss =
    css
    [ backgroundColor (rgb 141 196 243)

    ]