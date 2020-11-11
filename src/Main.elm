module Main exposing (main)

import Browser
import Html.Styled exposing (Html, div, toUnstyled)
import Html.Styled.Events
import Http exposing (get)
import Common exposing (Model, Msg(..))
import Tile exposing (makeTile)
import Header
import Html.Styled.Attributes exposing (class)
import Common exposing (Tile)
import Style exposing (mainCss)
import Style exposing (boardCss)
import Common exposing (contentDecoder)

main : Program () Model Msg
main =
    Browser.element
        { init = init
        , update = update
        , subscriptions = subscriptions
        , view = view >> toUnstyled
        }

init : () -> (Model, Cmd Msg)
init _ = 
    (
        { header = "bingo"
        , board = List.map makeTile (List.range 0 24)
        }
    , Http.get
        { url = "/content"
        , expect = Http.expectJson GotContent contentDecoder
        }
    )

update: Msg -> Model -> (Model, Cmd Msg)
update msg model = 
    case msg of 
        CheckTile idx ->
            ({model | board = flip idx model.board}, Cmd.none)
        GotContent result -> 
            case result of
                Ok content ->
                    (content, Cmd.none)
                Err _ -> 
                    (model, Cmd.none)
        
flip: Int -> List Tile -> List Tile
flip idx board = 
    case board of
        h :: t ->
            if idx == h.index && idx /= 25 then
                ({h | checked = not h.checked}) :: t
            else
                h :: (flip idx t)
        [] -> []

view: Model -> Html Msg
view model = 
    div [mainCss] [ (Header.view model.header)
    , div [boardCss] (List.map Tile.view model.board)
    ]

subscriptions: Model -> Sub Msg
subscriptions model =
    Sub.none