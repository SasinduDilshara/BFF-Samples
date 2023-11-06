import PropTypes from 'prop-types';
import {
  Box,
  Button,
  Card,
  Table,
  TableBody,
  TableCell,
  TableHead,
  TableRow,
} from '@mui/material';

export const CargosTable = (props) => {
  const {
    items = [],
    handleClick,
    open = false
  } = props;

  return (
    <Card>
        <Box sx={{ minWidth: 800 }}>
          <Table>
            <TableHead>
              <TableRow>
                <TableCell>
                  <b>ID</b>
                </TableCell>
                <TableCell>
                  <b>Status</b>
                </TableCell>
                <TableCell>
                  <b>Start From</b>
                </TableCell>
                <TableCell>
                  <b>End From</b>
                </TableCell>
                <TableCell>
                  <b>Type</b>
                </TableCell>
              </TableRow>
            </TableHead>
            <TableBody>
              {items.map((cargo) => {
                return (
                  <TableRow
                    hover
                    key={cargo.cargoId}
                  >
                    <TableCell>
                      {cargo.cargoId}
                    </TableCell>
                    <TableCell>
                      {cargo.status}
                    </TableCell>
                    <TableCell>
                      {cargo.startFrom}
                    </TableCell>
                    <TableCell>
                      {cargo.endFrom}
                    </TableCell>
                    <TableCell>
                      {cargo.type}
                    </TableCell>
                    <TableCell>
                      <Button onClick={() => handleClick(cargo.cargoId)}>View</Button>
                    </TableCell>
                  </TableRow>
                );
              })}
            </TableBody>
          </Table>
        </Box>
    </Card>
  );
};

CargosTable.propTypes = {
  count: PropTypes.number,
  items: PropTypes.array,
  handleClick: PropTypes.func,
  open: PropTypes.bool
};