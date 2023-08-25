import * as React from "react"
import Row from "./row"
import { VenueData } from "./venue"

interface VenueBodyProps {
  rows: number
  seatsPerRow: number
  ticketsToBuyCount: number
  concertId: number
  venueData: VenueData
}
const rowItems = ({
  rows,
  seatsPerRow,
  ticketsToBuyCount,
  concertId,
  venueData,
}) => {
  const rowNumbers = Array.from(Array(rows).keys())
  return rowNumbers.map((rowNumber) => (
    <Row
      key={rowNumber}
      rowNumber={rowNumber}
      seatsPerRow={seatsPerRow}
      ticketsToBuyCount={ticketsToBuyCount}
      concertId={concertId}
      rowData={venueData[rowNumber]}
    />
  ))
}
export const VenueBody = (props: VenueBodyProps): React.ReactElement => {
  return (
    <table className="table">
      <tbody>{rowItems(props)}</tbody>
    </table>
  )
}
export default VenueBody
