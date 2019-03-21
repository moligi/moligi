module Simple exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import DatePicker
import Date exposing (Date)
import Task


type alias Model =
    { calendar : DatePicker.DatePicker }


type Msg
    = DatePickerMsg DatePicker.Msg
    | PreviousMonth
    | NextMonth


main : Program Never Model Msg
main =
    program
        { init = init
        , update = update
        , subscriptions = always Sub.none
        , view = view
        }


init : ( Model, Cmd Msg )
init =
    ( { calendar = DatePicker.initCalendar DatePicker.Single }
    , Cmd.map DatePickerMsg DatePicker.receiveDate
    )


view : Model -> Html Msg
view model =
    div []
        [ h2 [ class "helvetica m0" ] [ text "Simple DatePicker" ]
        , button [ id "previous-month", class "bn pointer gray", onClick PreviousMonth ] [ text "<" ]
        , DatePicker.showCalendar model.calendar (DatePicker.getMonth model.calendar) DatePicker.defaultConfig
            |> Html.map DatePickerMsg
        , button [ id "next-month", class "bn pointer gray", onClick NextMonth ] [ text ">" ]
        ]


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        DatePickerMsg datePickerMsg ->
            { model | calendar = DatePicker.update datePickerMsg model.calendar } ! []

        PreviousMonth ->
            { model | calendar = DatePicker.previousMonth model.calendar } ! []

        NextMonth ->
            { model | calendar = DatePicker.nextMonth model.calendar } ! []
