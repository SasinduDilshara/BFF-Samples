import logo from './logo.svg';
import './App.css';
import CustomRouter from './routes';
import { ApolloClient, InMemoryCache, ApolloProvider } from '@apollo/client';
import { graphQlUrl } from './api/Constants';

function App() {

  const apolloClient = new ApolloClient({
    uri: graphQlUrl,
    cache: new InMemoryCache()
  });

  return (
    <ApolloProvider client={apolloClient}>
    <CustomRouter/>
    </ApolloProvider>
  );
}

export default App;
