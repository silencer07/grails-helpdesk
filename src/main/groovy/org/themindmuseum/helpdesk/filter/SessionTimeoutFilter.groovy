package org.themindmuseum.helpdesk.filter

import org.springframework.stereotype.Component

import javax.servlet.Filter
import javax.servlet.FilterChain
import javax.servlet.FilterConfig
import javax.servlet.ServletException
import javax.servlet.ServletRequest
import javax.servlet.ServletResponse
import javax.servlet.http.HttpServletResponse

/**
 * Created by aldrin on 11/19/15.
 */
@Component
class SessionTimeoutFilter implements Filter{
    @Override
    void init(FilterConfig filterConfig) throws ServletException {

    }

    @Override
    void doFilter(ServletRequest request, ServletResponse res, FilterChain chain) throws IOException, ServletException {
        HttpServletResponse response = (HttpServletResponse) res
        response.setHeader("Access-Control-Max-Age", "3600");
        chain.doFilter(request, response);
    }

    @Override
    void destroy() {

    }
}
