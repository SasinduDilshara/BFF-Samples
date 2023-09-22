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
import { Scrollbar } from 'src/components/scrollbar';

export const CargosTable = (props) => {
  const {
    items = [],
    handleClick,
    open = false
  } = props;

  console.log("Items: ", items);

  return (
    <Card>
      <Scrollbar>
        <Box sx={{ minWidth: 800 }}>
          <Table>
            <TableHead>
              <TableRow>
                <TableCell>
                  ID
                </TableCell>
                <TableCell>
                  Status
                </TableCell>
                <TableCell>
                  Start From
                </TableCell>
                <TableCell>
                  End From
                </TableCell>
                <TableCell>
                  Type
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
      </Scrollbar>
    </Card>
  );
};

CargosTable.propTypes = {
  count: PropTypes.number,
  items: PropTypes.array,
  handleClick: PropTypes.func,
  open: PropTypes.bool
};
