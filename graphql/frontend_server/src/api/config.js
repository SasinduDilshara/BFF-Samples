import { ApolloClient, InMemoryCache } from '@apollo/client';
import { graphQlUrl } from 'src/constants/Constants';

export const apolloClient1 = new ApolloClient({
    uri: graphQlUrl ,
    cache: new InMemoryCache()
  });

