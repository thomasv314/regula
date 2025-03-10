// Code generated by go-swagger; DO NOT EDIT.

package environments

// This file was generated by the swagger tool.
// Editing this file might prove futile when you re-run the swagger generate command

import (
	"context"
	"net/http"
	"time"

	"github.com/go-openapi/errors"
	"github.com/go-openapi/runtime"
	cr "github.com/go-openapi/runtime/client"
	"github.com/go-openapi/strfmt"

	"github.com/fugue/regula/pkg/swagger/models"
)

// NewUpdateEnvironmentParams creates a new UpdateEnvironmentParams object
// with the default values initialized.
func NewUpdateEnvironmentParams() *UpdateEnvironmentParams {
	var ()
	return &UpdateEnvironmentParams{

		timeout: cr.DefaultTimeout,
	}
}

// NewUpdateEnvironmentParamsWithTimeout creates a new UpdateEnvironmentParams object
// with the default values initialized, and the ability to set a timeout on a request
func NewUpdateEnvironmentParamsWithTimeout(timeout time.Duration) *UpdateEnvironmentParams {
	var ()
	return &UpdateEnvironmentParams{

		timeout: timeout,
	}
}

// NewUpdateEnvironmentParamsWithContext creates a new UpdateEnvironmentParams object
// with the default values initialized, and the ability to set a context for a request
func NewUpdateEnvironmentParamsWithContext(ctx context.Context) *UpdateEnvironmentParams {
	var ()
	return &UpdateEnvironmentParams{

		Context: ctx,
	}
}

// NewUpdateEnvironmentParamsWithHTTPClient creates a new UpdateEnvironmentParams object
// with the default values initialized, and the ability to set a custom HTTPClient for a request
func NewUpdateEnvironmentParamsWithHTTPClient(client *http.Client) *UpdateEnvironmentParams {
	var ()
	return &UpdateEnvironmentParams{
		HTTPClient: client,
	}
}

/*UpdateEnvironmentParams contains all the parameters to send to the API endpoint
for the update environment operation typically these are written to a http.Request
*/
type UpdateEnvironmentParams struct {

	/*Environment
	  Environment details to update.

	*/
	Environment *models.UpdateEnvironmentInput
	/*EnvironmentID
	  Environment ID.

	*/
	EnvironmentID string

	timeout    time.Duration
	Context    context.Context
	HTTPClient *http.Client
}

// WithTimeout adds the timeout to the update environment params
func (o *UpdateEnvironmentParams) WithTimeout(timeout time.Duration) *UpdateEnvironmentParams {
	o.SetTimeout(timeout)
	return o
}

// SetTimeout adds the timeout to the update environment params
func (o *UpdateEnvironmentParams) SetTimeout(timeout time.Duration) {
	o.timeout = timeout
}

// WithContext adds the context to the update environment params
func (o *UpdateEnvironmentParams) WithContext(ctx context.Context) *UpdateEnvironmentParams {
	o.SetContext(ctx)
	return o
}

// SetContext adds the context to the update environment params
func (o *UpdateEnvironmentParams) SetContext(ctx context.Context) {
	o.Context = ctx
}

// WithHTTPClient adds the HTTPClient to the update environment params
func (o *UpdateEnvironmentParams) WithHTTPClient(client *http.Client) *UpdateEnvironmentParams {
	o.SetHTTPClient(client)
	return o
}

// SetHTTPClient adds the HTTPClient to the update environment params
func (o *UpdateEnvironmentParams) SetHTTPClient(client *http.Client) {
	o.HTTPClient = client
}

// WithEnvironment adds the environment to the update environment params
func (o *UpdateEnvironmentParams) WithEnvironment(environment *models.UpdateEnvironmentInput) *UpdateEnvironmentParams {
	o.SetEnvironment(environment)
	return o
}

// SetEnvironment adds the environment to the update environment params
func (o *UpdateEnvironmentParams) SetEnvironment(environment *models.UpdateEnvironmentInput) {
	o.Environment = environment
}

// WithEnvironmentID adds the environmentID to the update environment params
func (o *UpdateEnvironmentParams) WithEnvironmentID(environmentID string) *UpdateEnvironmentParams {
	o.SetEnvironmentID(environmentID)
	return o
}

// SetEnvironmentID adds the environmentId to the update environment params
func (o *UpdateEnvironmentParams) SetEnvironmentID(environmentID string) {
	o.EnvironmentID = environmentID
}

// WriteToRequest writes these params to a swagger request
func (o *UpdateEnvironmentParams) WriteToRequest(r runtime.ClientRequest, reg strfmt.Registry) error {

	if err := r.SetTimeout(o.timeout); err != nil {
		return err
	}
	var res []error

	if o.Environment != nil {
		if err := r.SetBodyParam(o.Environment); err != nil {
			return err
		}
	}

	// path param environment_id
	if err := r.SetPathParam("environment_id", o.EnvironmentID); err != nil {
		return err
	}

	if len(res) > 0 {
		return errors.CompositeValidationError(res...)
	}
	return nil
}
