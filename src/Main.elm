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

view: Model -> Html Msg
view model = 
    div [mainCss] [ (Header.view model.header)
    , div [boardCss] (List.map Tile.view model.board)
    ]

subscriptions: Model -> Sub Msg
subscriptions model =
    Sub.none

-------------------------------------------------------

flip: Int -> List Tile -> List Tile
flip idx board = 
    case board of
        h :: t ->
            -- Tile ID 12 is the center, free space
            if idx == h.index && idx /= 12 then
                ({h | checked = not h.checked}) :: t
            else
                h :: (flip idx t)
        [] -> []

tileChecked: Tile -> Bool
tileChecked tile = tile.checked

rowBingo: List Tile -> Tile -> Bool
rowBingo board tile =
    let row = tile.index // 5 in
    List.all tileChecked <| List.filter (\t -> t.index // 5 == row) board

colBingo: List Tile -> Tile -> Bool
colBingo board tile = 
    let col = modBy 5 tile.index in
    List.all tileChecked <| List.filter (\t -> (modBy 5 t.index) == col) board

bingo: List Tile -> Tile -> Bool
bingo board tile = (rowBingo board tile) || (colBingo board tile)