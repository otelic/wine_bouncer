module WineBouncer
  module AuthStrategies
    class Default

      def endpoint_protected?(context)
        has_authorizations?(context)
      end

      def endpoint_protection_optional?(context)
        endpoint_protected?(context) &&
          endpoint_authorizations(context).has_key?(:optional) &&
          endpoint_authorizations(context)[:optional] == true
      end

      def has_auth_scopes?(context)
        has_authorizations?(context) &&
          endpoint_authorizations(context).has_key?(:scopes) &&
          !endpoint_authorizations(context)[:scopes].empty?
      end

      def auth_scopes(context)
        endpoint_authorizations(context)[:scopes].map(&:to_sym)
      end

      private

      def has_authorizations?(context)
        !!endpoint_authorizations(context)
      end

      def endpoint_authorizations(context)
         context[:auth]
      end
    end
  end
end
